class PasswordController < ApplicationController
  # Called when user hits forgot password button. Is the reset page
  def reset
    render :reset

  end
  # This will make sure user exists then generate a password for them
  def send_email
    @email = params[:email]
    # The person is a user
    if User.exists?(email: @email)
      # We want the ASCII range of letters, symbols and numbers
      new_password = ""
      for a in 1..9 do
        new_password += (rand(90) + 33).chr
      end
      # Spaces are problematic so rid them
      @user = User.find_by(email: params[:email])
      new_password = new_password.delete(' ')
      # Reset the users password then send this new password to them via email
      @user.update_attribute(:password, new_password)
      message = "Email sent!"
      puts "\n"
      puts `python3 smtp.py #{@email} "5" "#{new_password}"`
      # We cant reset if they dont exist so we route them to login with this message
    else
      message = "Email does not exist! Please create an account"
    end
    redirect_to login_path, notice: message
  end

end
