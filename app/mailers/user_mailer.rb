class UserMailer < ApplicationMailer
   default from: "quanboys012@gmail.com"

   def reset_password_instructions(user)
     @user = user
      mail to: user.email, :subject => 'KHÔI PHỤC MẬT KHẨU TÀI KHOẢN'
    end

#     def notify_import(user, file, file_name, subject)
#       @user = user
#       attachments[file_name] = File.read(file)
#       mail to: @user.email, :subject => subject
#     end
  end
