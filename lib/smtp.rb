email = { :address              => "smtp.gmail.com",
            :port                 => 465,
            :domain               => '127.0.0.1:3000',
            :user_name            => "littlerascalsfall21",
            :password             => 'Littlerascals1',
            :authentication       => :login,
            :ssl                  => true,
            :openssl_verify_mode  => 'none'
}

Mail.defaults do
  delivery_method :smtp, email
end

def send_email(recipient, subject_of_email)
  Mail.deliver do
    to recipient
    from 'littlerascalsfall21@gmail.com'
    subject subject_of_email
    body  "Form submitted at: " + Time.new.strftime("%Y-%m-%d %H:%M:%S") + "! Great work."
  end
end