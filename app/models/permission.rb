class Permission < ApplicationRecord
  belongs_to :role

  LIST_MODEL_NAME = {
    "Khách hàng" => 'Customer',
    "Tài khoản nội bộ" => 'User',
    "Chủ đầu tư" => "Investor",
    "Tổng thầu" => "Constructor",
    "Đơn vị phát triển" => "Development",
    "Đơn vị quản lý" => "Operator",
    "Dự án" => "Project",
    "Bảng hàng sản phẩm" => "Product",
    #"Mặt bằng" => "Layout",
    #"Đăng ký tư vấn" => "CustomerTicket",
    #"Banner" => "Banner",
    #"Tùy chỉnh trang chủ" => "CustomHtml",
    #"Tuỳ chỉnh chi tiết dự án" => "CustomDetail",
    #"Tài khoản khách hàng" => "Account",
    "Phân quyền" => 'Role',
    #"Sơ đồ tổ chức" => 'Group',
    #"Giao dịch" => 'Deal',
    #"Cơ chế hoa hồng" => 'Regulation'
  }
end
