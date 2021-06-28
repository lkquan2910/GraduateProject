# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  layout 'application', :only => [:profile, :update_profile]
  def profile
  end

  def update_profile
    respond_to do |format|
      if current_user.update(profile_params)
        bypass_sign_in(current_user)
        format.html { redirect_to user_profile_path, notice: 'Tài khoản đã được chỉnh sửa thành công.' }
        format.json { render :profile, status: :ok, location: current_user }
      else
        format.html { render :profile }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_attachment
    current_user.remove_avatar!
    if current_user.valid?
      current_user.save
      current_user.reload
      render json: {}
    else
      render json: { error: current_user.errors[params[:type].to_sym]&.first }
    end
  end

  def subscribe
    if params['subscribe'].to_s == 'false'
      current_user.unsubscribe
      return render body: nil
    end
    current_user.update(
      auth_key: params[:subscription][:keys][:auth],
      endpoint: params[:subscription][:endpoint],
      p256dh_key: params[:subscription][:keys][:p256dh],
      subscribe: true
    )
    session.delete(:refresh_subscribe)
    render body: nil
  end

  def profile_params
    if params[:user][:password_confirmation].present?
      params.fetch(:user, {}).permit(:full_name, :avatar, :password, :password_confirmation)
    else
      params.fetch(:user, {}).permit(:full_name, :avatar)
    end
  end
end
