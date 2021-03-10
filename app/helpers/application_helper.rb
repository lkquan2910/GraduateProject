module ApplicationHelper
  include Pagy::Frontend

  def current_path *paths
    paths.map { |path| current_page? path }.include?(true) ? 'active' : ''
  end

  def nav_item_show *paths
    paths.map { |path| current_page? path }.include?(true) ? 'show' : ''
  end
end
