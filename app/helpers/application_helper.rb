module ApplicationHelper
  include Pagy::Frontend

  def constant_options constant, sublayer = nil
    (sublayer.present? ? constant[sublayer]&.invert : constant&.invert) || {}
  end

  def current_path *paths
    paths.map { |path| current_page? path }.include?(true) ? 'active' : ''
  end

  def nav_item_show *paths
    paths.map { |path| current_page? path }.include?(true) ? 'show' : ''
  end
end
