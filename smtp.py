import sys
import datetime
import smtplib

gmail_user = 'littlerascalsfall21@gmail.com'
gmail_password = 'Littlerascals1!'

try:
    server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
    server.ehlo()
    server.login(gmail_user, gmail_password)

    to = sys.argv[1]
    fromEmail = "Little Rascals <littlerascalsfall21@gmail.com>"
    msg_type = sys.argv[2]
    print("\n\nSMTP--Sending to: ",to, " ", msg_type,"\n\n")
    if int(msg_type) == 1:
        subject = "Form Successfully Submitted"
        date = datetime.datetime.now().strftime("%d/%m/%Y %H:%M")
        message_text = "Congrats!\nYou submitted a form at %s\n\n-Littlerascals :)" % date
        message = "From: %s\nTo: %s\nSubject: %s\nDate: %s\n\n%s" % (fromEmail, to, subject,
                                                                     date, message_text)
    elif int(msg_type) == 2:
        subject = "You Have Successfully Created an Account"
        date = datetime.datetime.now().strftime("%d/%m/%Y %H:%M")
        message_text = "Account created at %s for email: %s \n\n-Littlerascals :)" % (date, to)
        message = "From: %s\nTo: %s\nSubject: %s\nDate: %s\n\n%s" % (fromEmail, to, subject,
                                                                     date, message_text)
    elif int(msg_type) == 3:
        print("ENTEREED\n\n\n", to)
        subject = "You Have Been Assigned a New Poll"
        date = datetime.datetime.now().strftime("%d/%m/%Y %H:%M")
        message_text = "A new poll assignment was created at %s\n\n-Littlerascals" % date
        message = "From: %s\nTo: %s\nSubject: %s\nDate: %s\n\n%s" % (fromEmail, to, subject,
                                                                     date, message_text)
    elif int(msg_type) == 4:
        student_name = sys.argv[3]
        subject = "Student's Score Below Threshold"
        date = datetime.datetime.now().strftime("%d/%m/%Y %H:%M")
        message_text = "Student %s has a score that is below the expected threshold\n\n-Littlerascals" % student_name
        message = "From: %s\nTo: %s\nSubject: %s\nDate: %s\n\n%s" % (fromEmail, to, subject,
                                                                     date, message_text)

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
