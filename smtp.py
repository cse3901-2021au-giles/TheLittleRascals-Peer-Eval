import sys
import datetime
import smtplib

# The email used to send content to users. Login format
gmail_user = 'littlerascalsfall21@gmail.com'
gmail_password = 'Littlerascals1!'

# We want to catch any errors it might throw
try:
    server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
    server.ehlo()
    server.login(gmail_user, gmail_password)

    # Who the email is going to is always passed as the first argument
    to = sys.argv[1]
    # This is our send format. Msg_type indicates what kind of email we want to send
    fromEmail = "Little Rascals <littlerascalsfall21@gmail.com>"
    msg_type = sys.argv[2]
    print("\n\nSMTP--Sending to: ",to, " ", msg_type,"\n\n")
    # Mode one which indicates that the user
    if int(msg_type) == 1:
        subject = "Form Successfully Submitted"
        date = datetime.datetime.now().strftime("%d/%m/%Y %H:%M")
        message_text = "Congrats!\nYou submitted a form at %s\n\n-Littlerascals :)" % date
        message = "From: %s\nTo: %s\nSubject: %s\nDate: %s\n\n%s" % (fromEmail, to, subject,
                                                                     date, message_text)
     # Mode two notifies the user of their successful account creation
    elif int(msg_type) == 2:
        subject = "You Have Successfully Created an Account"
        date = datetime.datetime.now().strftime("%d/%m/%Y %H:%M")
        message_text = "Account created at %s for email: %s \n\n-Littlerascals :)" % (date, to)
        message = "From: %s\nTo: %s\nSubject: %s\nDate: %s\n\n%s" % (fromEmail, to, subject,
                                                                     date, message_text)
      # Mode three lets the user know when they have been assigned a poll
    elif int(msg_type) == 3:
        subject = "You Have Been Assigned a New Poll"
        date = datetime.datetime.now().strftime("%d/%m/%Y %H:%M")
        message_text = "A new poll assignment was created at %s\n\n-Littlerascals" % date
        message = "From: %s\nTo: %s\nSubject: %s\nDate: %s\n\n%s" % (fromEmail, to, subject,
                                                                     date, message_text)
     # Mode four is when the teacher creates an account for a student.
    elif int(msg_type) == 4:
            subject = "Account Created"
            date = datetime.datetime.now().strftime("%d/%m/%Y %H:%M")
            message_text = "Account created at %s for email: %s \nEnter any password at login\n-Littlerascals :)" % (date, to)
            message = "From: %s\nTo: %s\nSubject: %s\nDate: %s\n\n%s" % (fromEmail, to, subject,
                                                                         date, message_text)
     # Mode five takes in an additional parameter which sends their reset password
    elif int(msg_type) == 5:
            temp_password = sys.argv[3]
            subject = "Password Has Been Reset"
            date = datetime.datetime.now().strftime("%d/%m/%Y %H:%M")
            message_text = "Your password has been temporarily changed to: %s\n\n-Littlerascals" % temp_password
            message = "From: %s\nTo: %s\nSubject: %s\nDate: %s\n\n%s" % (fromEmail, to, subject,
                                                                         date, message_text)

    server.sendmail(fromEmail, to, message)
    server.quit()
except:
    print('Error sending email! Make sure that python is installed and on path!')
