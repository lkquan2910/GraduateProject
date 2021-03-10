# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  def create
    user = User.find_by_email(params[:user][:email])
    if user.blank?
      redirect_to new_user_password_path, notice: 'Email không tồn tại trong hệ thống. Vui lòng thử lại.'
      #elsif user.deactivated?
      #  redirect_to new_user_password_path, notice: 'Tài khoản của bạn đã bị vô hiệu hóa.'
    else
      user.send_password_reset
      UserMailer.reset_password_instructions(user).deliver_later(wait: 5.seconds)
      redirect_to root_path, notice: 'Hướng dẫn đặt lại mật khẩu đã được gửi vào email của bạn. Vui lòng kiểm tra hộp thư và thực hiện theo hướng dẫn.'
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  def update
    user = User.find_by(reset_password_token: params[:user][:reset_password_token])
    if user.present?
      user.password = params[:user][:password]
      user.password_confirmation = params[:user][:password_confirmation]
      if user.save
        flash[:notice] = 'Đổi mật khẩu thành công.'
        redirect_to root_path
      end
    else
      redirect_to new_user_password_path, notice: 'Đã xảy ra lỗi vui lòng thử lại.'
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
