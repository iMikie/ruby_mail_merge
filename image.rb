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
mailman.put_SmtpHost("smtp.mail.me.com")
mailman.put_SmtpUsername("mikefarr")
mailman.put_SmtpPassword("Europa73")
mailman.put_SmtpSsl(false)
mailman.put_StartTLS(true)
mailman.put_SmtpPort(587)

#  Create a new email object
email = Chilkat::CkEmail.new()
email.put_Subject("Sending email from Ruby")
email.put_From("mikefarr@mac.com")
email.AddTo("Mike", "mikefarr@mac.com")


#  Add an embedded image to the HTML email.
fileOnDisk     = "image003.jpg"
filePathInHtml = "image003.jpg"

#  Embed the GIF image in the email.
success        = email.AddRelatedFile2(fileOnDisk, filePathInHtml)
if (success != true)
  print mailman.lastErrorText() + "\n";
  exit
end

#  The src attribute for the image tag is set to the filePathInHtml:
htmlBody = "<html><body>Embedded Image:<br><img src=\"image003.jpg\"></body></html>"

#  Set the basic email stuff: HTML body, subject, "from", "to";
email.SetHtmlBody(htmlBody)

success = mailman.SendEmail(email)
if (success != true)
  print mailman.lastErrorText() + "\n";
else
  print "Mail Sent!" + "\n"
end
