class PasswordController < ApplicationController
  def reset
    render :reset

  end
  def send_email
    @email = params[:email]
    if User.exists?(email: @email)
      password = ""
      for a in 1..9 do
        password += (rand(90) + 33).chr
      end
      @user = User.find_by(email: params[:email])
      @user.password = password.delete(' ')
      # @user.save
      message = "Email sent!"
    puts `\npython3 smtp.py #{@email} "5" "#{password}"`
    else
      message = "Email does not exist! Please create an account"
    end
    redirect_to login_path, notice: message
  end

end
