class PasswordController < ApplicationController
  def reset
    render :reset

  end
  def send_email
    @email = params[:email]
    if User.exists?(email: @email)
      new_password = ""
      for a in 1..9 do
        new_password += (rand(90) + 33).chr
      end
      @user = User.find_by(email: params[:email])
      new_password = new_password.delete(' ')
      @user.update_attribute(:password, new_password)
      message = "Email sent!"
    puts `\npython3 smtp.py #{@email} "5" "#{new_password}"`
    else
      message = "Email does not exist! Please create an account"
    end
    redirect_to login_path, notice: message
  end

end
