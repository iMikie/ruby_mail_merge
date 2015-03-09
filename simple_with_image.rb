require 'chilkat'

#  Create a MailMan for the purpose
#  of unlocking the component.
mailman = Chilkat::CkMailMan.new()
success = mailman.UnlockComponent("30-day trial")

if (success != true)
  print mailman.lastErrorText() + "\n";
  exit
end
#iCloud SMTP information
mailman.put_SmtpHost("smtp.mail.me.com")
mailman.put_SmtpUsername("mikefarr")
mailman.put_SmtpPassword("password")
mailman.put_SmtpSsl(false)
mailman.put_StartTLS(true)
mailman.put_SmtpPort(587)


#  Create a new email object
email = Chilkat::CkEmail.new()

#  Add some headers:
email.put_Subject("This is a complex email")

#  Add a plain-text body:
email.AddPlainTextAlternativeBody("This is the plain-text body")

#  Add an image that will be embedded in the HTML body.
#  The contentType as derived from the file extension is returned.
filenameOnDisk = "dude.jpg"
filenameInHtml = "dude.jpg"
success        = email.AddRelatedFile2(filenameOnDisk, filenameInHtml)
if (success != true)
  print email.lastErrorText() + "\n";
end

#  Add an HTML body:

html = "<html><body><b>This is the HTML body</b><br><img src=\"dude.jpg\"></body></html>"

email.AddHtmlAlternativeBody(html)

#  Save the email as a .eml

success = email.SaveEml("complex.eml")
if (success != true)
  print email.lastErrorText() + "\n";
else
  print "Created email!" + "\n"
end

