require "axlsx"
class ProductService
  def initialize file_path = nil, project_id = nil, user = nil
    @file_path = file_path
    @project = Project.find_by id: project_id
    @user = user
    @divisions_cache = []
  end

  def export_template
    p = Axlsx::Package.new
    wb = p.workbook
    @header = wb.styles.add_style bg_color: '3ac5c9', fg_color: 'FF', b: true
    add_worksheet(wb, 'Cao tầng', high_columns)
    add_worksheet(wb, 'Thấp tầng', low_columns)
    p
  end

  def import
    ods = open_spreadsheet(@file_path)
    @result_file = Axlsx::Package.new
    @import_success = true
    ods.each_with_pagename do |nameSheet, spreadsheet|
      wb = @result_file.workbook
      @ws = wb.add_worksheet(name: nameSheet)
      style = wb.styles.add_style bg_color: '3ac5c9', fg_color: 'FF', b: true
      @ws.add_row ['Vị trí', 'Nội dung lỗi'], style: style

      add_error('Dự án', 'Chưa chọn dự án  bảng hàng') and return unless @project.present?
      add_error('Max size', 'Giới hạn import mỗi lần là 1000 dòng') and next if spreadsheet.count > 1000

      import_data nameSheet, spreadsheet
    end

    # TODO
    if @import_success
      {message: 'Dữ liệu đã được tải lên thành công'}
      # Send notification
    else
      tempfile = File.new("#{Rails.root}/public/product_error.xlsx", "w")
      @result_file.serialize tempfile
      UserMailer.notify_import(@user, tempfile, 'product_error.xlsx', 'Thông báo lỗi import bảng hàng').deliver
      ::File.delete tempfile
      {message: "Có một số lỗi xảy ra khi tải dữ liệu lên. Vui lòng check email < #{@user.email} > để xem chi tiết"}
      # Send notification
      # Send result file to mail
      # @result_file
    end
  end

  private
  def open_spreadsheet(file_path)
    case File.extname(file_path)
    when '.csv' then
      Roo::CSV.new(file_path)
    when '.xls' then
      Roo::Excel.new(file_path)
    when '.xlsx' then
      Roo::Excelx.new(file_path)
    else
      raise "Unknown file type: #{File.basename(file_path, ".*")}"
    end
  end

  def import_data nameSheet, spreadsheet
    level = Constant::PRODUCT_LEVELS.invert[nameSheet]
    @column_settings = level == 0 ? high_columns : low_columns
    header = spreadsheet.row(1)
    @columns = []

    header.each_with_index do |field, index|
      column_setting = @column_settings.detect{|cs| cs[:title] == field.strip }
      add_error('Header', "Không tồn tại trường dữ liệu #{field} trong sản phẩm") and return unless column_setting.present?
      @columns[index] = column_setting
    end

    products = []
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)

      # TODO: default state_id,
      product = Product.new(level: level, project_id: @project.id, created_by_id: @user.id)
      divisions = {}
      row.each_with_index do |cell, index|
        column = @columns[index]
        value = cell_value cell, column
        case column[:field]
        when :code
          product[column[:field]] = value
          product[:slug] = ("#{value} #{product.project.name}").mb_chars.normalize(:kd).gsub(/\p{Mn}/, '').downcase.to_s.parameterize
        when :subdivision_id
          divisions[:subdivision] = value
        when :block_id
          divisions[:block] = value
        when :floor_id
          divisions[:floor] = value
        else
          product[column[:field]] = value
        end
      end
      next unless product.present?

      temp_div = Division.new name: divisions[:subdivision]
      temp_block = Division.new name: divisions[:block]
      temp_floor = Division.new name: divisions[:floor]
      blank_div_error = []
      blank_div_error << I18n.t("alert.division_blank", name: Constant::PRODUCT_DIVISION_TYPES[0]) unless temp_div.valid?
      blank_div_error << I18n.t("alert.division_blank", name: (level == 0 ? Constant::PRODUCT_DIVISION_TYPES[1] : Constant::PRODUCT_DIVISION_TYPES[2])) unless temp_block.valid?
      blank_div_error << I18n.t("alert.division_blank", name: Constant::PRODUCT_DIVISION_TYPES[3]) if level == 0 && !temp_floor.valid?
      if blank_div_error.present?
        add_error "Dòng #{i}", blank_div_error.join(', ')
        next
      end

      subdivision_id, block_id, floor_id = get_divisions divisions, level
      product.subdivision_id = subdivision_id
      product.block_id = block_id
      product.floor_id = floor_id

      unless product.valid?
        add_error("Dòng #{i}", product.errors.full_messages.join(", "))
        next
      end
      products << product
    end

    result = Product.import products, batch_size: 100
    result.failed_instances.each do |failure|
      puts "Import product error: #{failure.errors}"
    end
    Product.reindex
  end

  def cell_value cell, column
    case column[:type]
    when 'text'
      cell = cell.to_i if column[:field] == :name && cell.kind_of?(Float)
      cell = cell.to_s
    when 'dropdown'
      cell = column[:value].invert[cell]
    when 'numeric'
      cell = cell.to_f > 0 ? cell.to_f : nil
    end
    cell.kind_of?(String) ? cell.strip.gsub('_x0008_', '').gsub(/[^[:print:]]/i, '') : cell
  end

  def get_divisions div, level
    subdivision_id = @divisions_cache.find{|d| d[:project_id] == @project.id && d[:name] == div[:subdivision]}.try(:[], :id) ||
      @project.divisions.find_by(name: div[:subdivision])&.id ||
      Division.create(name: div[:subdivision], project_id: @project.id, label: 0, level: level)&.id
    @divisions_cache << {project_id: @project.id, name: div[:subdivision], id: subdivision_id}

    block_id = @divisions_cache.find{|d| d[:parent_id] == subdivision_id && d[:name] == div[:block]}.try(:[], :id) ||
      Division.find_by(parent_id: subdivision_id, name: div[:block])&.id ||
      Division.create(name: div[:block], parent_id: subdivision_id, label: (level == 0 ? 1 : 2), level: level)&.id
    @divisions_cache << {parent_id: subdivision_id, name: div[:block], id: block_id}

    if div[:floor].present?
      floor_id = @divisions_cache.find{|d| d[:parent_id] == @project.id && d[:name] == div[:floor]}.try(:[], :id) ||
        Division.find_by(parent_id: block_id, name: div[:floor])&.id ||
        Division.create(name: div[:floor], parent_id: block_id, label: 3, level: level)&.id
      @divisions_cache << {parent_id: block_id, name: div[:floor], id: floor_id}
    end

    return subdivision_id, block_id, floor_id
  end

  def add_error info, message
    @import_success = false
    @ws.add_row [info, message]
  end

  def columnName num
    return 0 if num <= 0
    while num > 0 do
      mod = (num - 1) % 26
      name = (65 + mod).chr + (name || '')
      num = ((num - mod) / 26).to_i
    end
    name
  end

  def add_worksheet wb, name, columns
    header = columns.map{|c| c[:title]}
    wb.add_worksheet(name: name) do |ws|
      ws.add_row header, style: @header
      columns.each_with_index do |col, index|
        col_name = columnName(index + 1)
        case col[:type]
        when 'text'
          ws.add_data_validation("#{col_name}2:#{col_name}1000", {
            type: :textLength,
            operator: :between,
            formula1: "#{col[:value].first}",
            formula2: "#{col[:value].last}",
            showErrorMessage: true,
            errorTitle: col[:title],
            error: "Phải ít hơn #{col[:value].last} ký tự",
            errorStyle: :stop,
            showInputMessage: true,
            promptTitle: '',
            prompt: "Bắt buộc nhập, không vượt quá #{col[:value].last} ký tự"})
        when 'dropdown'
          ws.add_data_validation("#{col_name}2:#{col_name}1000", {
            type: :list,
            formula1: '"' + col[:value]&.values&.join(', ') + '"',
            showDropDown: false,
            showErrorMessage: true,
            errorTitle: col[:title],
            error: 'Chỉ được chọn các giá trị trong dropdown',
            errorStyle: :stop,
            showInputMessage: true,
            promptTitle: '',
            prompt: 'Chọn các giá trị trong dropdown'})
        when 'numeric'
          ws.add_data_validation("#{col_name}2:#{col_name}1000", {
            type: :whole,
            operator: :greaterThanOrEqual,
            formula1: "#{col[:value].first}",
            showErrorMessage: true,
            errorTitle: col[:title],
            error: "Phải nhập số lớn hơn hoặc bằng #{col[:value].first}",
            errorStyle: :stop,
            showInputMessage: true,
            promptTitle: '',
            prompt: "Nhập số lớn hơn hoặc bằng #{col[:value].first}"})
        end
      end
    end
  end

  def low_columns
    [
      {
        title: I18n.t("product.template.low.code"),
        field: :code,
        type: 'text',
        value: [1, 255]
      },
      {
        title: I18n.t("product.template.low.subdivision"),
        field: :subdivision_id,
        type: 'text',
        value: [1, 255]
      },
      {
        title: I18n.t("product.template.low.block"),
        field: :block_id,
        type: 'text',
        value: [1, 255]
      },
      {
        title: I18n.t("product.template.low.name"),
        field: :name,
        type: 'text',
        value: [1, 255]
      },
      {
        title: I18n.t("product.template.low.real_estate_type"),
        field: :real_estate_type,
        type: 'dropdown',
        value: Constant::PRODUCT_REAL_ESTATE_TYPES[1]
      },
      {
        title: I18n.t("product.template.low.product_type"),
        field: :product_type,
        type: 'text',
        value: [1, 255]
      },
      {
        title: I18n.t("product.template.low.direction"),
        field: :direction,
        type: 'dropdown',
        value: Constant::PRODUCT_DIRECTIONS
      },
      {
        title: I18n.t("product.template.low.plot_area"),
        field: :plot_area,
        type: 'numeric',
        value: [0]
      },
      {
        title: I18n.t("product.template.low.density"),
        field: :density,
        type: 'numeric',
        value: [0]
      },
      {
        title: I18n.t("product.template.low.floor_area"),
        field: :floor_area,
        type: 'numeric',
        value: [0]
      },
      {
        title: I18n.t("product.template.low.statics"),
        field: :statics,
        type: 'text',
        value: [1, 255]
      },
      {
        title: I18n.t("product.template.low.currency"),
        field: :currency,
        type: 'dropdown',
        value: Constant::PRODUCT_CURRENCIES
      },
      {
        title: I18n.t("product.template.low.price"),
        field: :price,
        type: 'numeric',
        value: [0]
      },
      {
        title: I18n.t("product.template.low.sum_price"),
        field: :sum_price,
        type: 'numeric',
        value: [0]
      },
      {
        title: I18n.t("product.template.low.certificate"),
        field: :certificate,
        type: 'dropdown',
        value: Constant::PRODUCT_CERTIFICATES
      },
      {
        title: I18n.t("product.template.low.use_term"),
        field: :use_term,
        type: 'dropdown',
        value: Constant::PRODUCT_USE_TERMS
      },
      {
        title: I18n.t("product.template.low.handover_standards"),
        field: :handover_standards,
        type: 'text',
        value: [1, 255]
      },
      {
        title: I18n.t("product.template.low.deposit"),
        field: :deposit,
        type: 'numeric',
        value: [0]
      }
    ]
  end

  def high_columns
    [
      {
        title: I18n.t("product.template.high.code"),
        field: :code,
        type: 'text',
        value: [1, 255]
      },
      {
        title: I18n.t("product.template.high.subdivision"),
        field: :subdivision_id,
        type: 'text',
        value: [1, 255]
      },
      {
        title: I18n.t("product.template.high.block"),
        field: :block_id,
        type: 'text',
        value: [1, 255]
      },
      {
        title: I18n.t("product.template.high.floor"),
        field: :floor_id,
        type: 'text',
        value: [1, 255]
      },
      {
        title: I18n.t("product.template.high.name"),
        field: :name,
        type: 'text',
        value: [1, 255]
      },
      {
        title: I18n.t("product.template.high.real_estate_type"),
        field: :real_estate_type,
        type: 'dropdown',
        value: Constant::PRODUCT_REAL_ESTATE_TYPES[0]
      },
      {
        title: I18n.t("product.template.high.product_type"),
        field: :product_type,
        type: 'text',
        value: [1, 255]
      },
      {
        title: I18n.t("product.template.high.direction"),
        field: :direction,
        type: 'dropdown',
        value: Constant::PRODUCT_DIRECTIONS
      },
      {
        title: I18n.t("product.template.high.built_up_area"),
        field: :built_up_area,
        type: 'numeric',
        value: [0]
      },
      {
        title: I18n.t("product.template.high.carpet_area"),
        field: :carpet_area,
        type: 'numeric',
        value: [0]
      },
      {
        title: I18n.t("product.template.high.currency"),
        field: :currency,
        type: 'dropdown',
        value: Constant::PRODUCT_CURRENCIES
      },
      {
        title: I18n.t("product.template.high.price"),
        field: :price,
        type: 'numeric',
        value: [0]
      },
      {
        title: I18n.t("product.template.high.sum_price"),
        field: :sum_price,
        type: 'numeric',
        value: [0]
      },
      {
        title: I18n.t("product.template.high.certificate"),
        field: :certificate,
        type: 'dropdown',
        value: Constant::PRODUCT_CERTIFICATES
      },
      {
        title: I18n.t("product.template.high.use_term"),
        field: :use_term,
        type: 'dropdown',
        value: Constant::PRODUCT_USE_TERMS
      },
      {
        title: I18n.t("product.template.high.furniture"),
        field: :furniture,
        type: 'dropdown',
        value: Constant::PRODUCT_FURNITURES
      },
      {
        title: I18n.t("product.template.high.furniture_quality"),
        field: :furniture_quality,
        type: 'dropdown',
        value: Constant::PRODUCT_FURN_QUALITIES
      },
      {
        title: I18n.t("product.template.high.deposit"),
        field: :deposit,
        type: 'numeric',
        value: [0]
      }
    ]
  end
end
