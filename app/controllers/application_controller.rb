class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!
  before_action :set_current_user

  def set_current_user
    User.current = current_user
  end

  private

  def user_not_authorized
    flash[:warning] = "Bạn không có quyền thực hiện hành động này."
    redirect_to(request.referrer || root_path)
  end

end
