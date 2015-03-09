# file: SendEmail.rb

#require 'rubygems'
require 'chilkat'

#  The mailman object is used for receiving (POP3)
#  and sending (SMTP) email.


def send_an_email(email_address, name)


  mailman = Chilkat::CkMailMan.new()
  success = mailman.UnlockComponent("30-day trial")

  if (success != true)
    print mailman.lastErrorText() + "\n";
    exit
  end

#  Create a new email object
  email   = Chilkat::CkEmail.new()

#  The MHT component can be used to convert an HTML page
#  from a URL, file, or in-memory HTML into an email
#  with embedded images and style sheets.
  mht     = Chilkat::CkMht.new()
  success = mht.UnlockComponent("30-day trial")
  if (success != true)
    print mht.lastErrorText() + "\n";
    exit
  end


#use content IDs, whatever those are
  mht.put_UseCids(true)

  emlStr = mht.getEML("MoC.html")
#emlStr = File.read("MonstersoftheCosmos.eml")
  if (emlStr == nil)
    print mht.lastErrorText() + "\n";
    exit
  end
  success = email.SetFromMimeText(emlStr)
  if (success != true)
    print email.lastErrorText() + "\n";
    exit
  end

#iCloud SMTP information
  mailman.put_SmtpHost("smtp.mail.me.com")
  mailman.put_SmtpUsername("mikefarr")
  mailman.put_SmtpPassword("Europa73")
  mailman.put_SmtpSsl(false)
  mailman.put_StartTLS(true)
  mailman.put_SmtpPort(587)


# html_file = File.read("greetings.html")
# if (html_file == nil )
#   print mht.lastErrorText() + "\n";
#   exit
# end

#mime = mht.htmlToEML(html_file)
#
# #  Add an image that will be embedded in the HTML body.
# #  The contentType as derived from the file extension is returned.
# filenameOnDisk = "moc.jpg"
# filenameInHtml = "moc.jpg"
# success = email.AddRelatedFile2(filenameOnDisk,filenameInHtml)
# if (success != true)
#   print email.lastErrorText() + "\n";
# end


#Inline email text could be done like this
# html =<<EOF
# <html><body><br>
# <b>Hi All,</b>
# <br>
# What format would you like it in?
# Thanks,
# Mike<br>
# </body></html>
# EOF

#Fill ChilKat email object
#email.SetFromMimeText(mime)
#email.put_Body(text_body) #if just text

  email.put_Subject("Monsters of the Cosmos")
  email.put_From("mikefarr@mac.com")
  email.AddTo(name, email_address)
# To add more recipients, simply repeat
#email.AddTo("Somebody","somebody@somewhere.com")

  success = mailman.SendEmail(email)
  if not success
    mailman.SaveLastError("lastError.xml")
    print mailman.lastErrorText() + "\n";
  end

  success = mailman.CloseSmtpConnection()
  if (success != true)
    print "Connection to SMTP server not closed cleanly." + "\n"
  end

  print "Mail Sent!" + "\n"
end

