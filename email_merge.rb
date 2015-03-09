require 'chilkat'

#  The mailman object is used for sending and receiving email.
mailman = Chilkat::CkMailMan.new()

#  Any string argument automatically begins the 30-day trial.
success = mailman.UnlockComponent("30-day trial")
if (success != true)
  print mailman.lastErrorText() + "\n";
  exit
end

#  Set the SMTP server.
mailman.put_SmtpHost("smtp.chilkatsoft.com")

#  Set the SMTP login/password (if required)
mailman.put_SmtpHost("smtp.mail.me.com")
mailman.put_SmtpUsername("mikefarr")
mailman.put_SmtpPassword("Europa73")
mailman.put_SmtpSsl(false)
mailman.put_StartTLS(true)
mailman.put_SmtpPort(587)
#
#  Create a new email object
email = Chilkat::CkEmail.new()

email.put_Subject("This is a test")
email.put_Body("This is a test body")
email.put_From("Mike Farr <mikefarr@mac.com>")
email.AddTo("Mike Farr", "<mikefarr@mac.com>")
#  To add more recipients, call AddTo, AddCC, or AddBcc once per recipient.

#  Call SendEmail to connect to the SMTP server and send.
#  The connection (i.e. session) to the SMTP server remains
#  open so that subsequent SendEmail calls may use the
#  same connection.
success = mailman.SendEmail(email)
if (success != true)
  print mailman.lastErrorText() + "\n";
  exit
end

#  Some SMTP servers do not actually send the email until
#  the connection is closed.  In these cases, it is necessary to
#  call CloseSmtpConnection for the mail to be  sent.
#  Most SMTP servers send the email immediately, and it is
#  not required to close the connection.  We'll close it here
#  for the example:
success = mailman.CloseSmtpConnection()
if (success != true)
  print "Connection to SMTP server not closed cleanly." + "\n"
end

print "Mail Sent!" + "\n"