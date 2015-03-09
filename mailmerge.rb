require_relative "sendmail.rb"
require "csv"
puts "Mail merge initialized."

contents = CSV.open "MoC.csv", headers: true, header_converters: :symbol

send_an_email("john@symphonyofscience.com", "John")
send_an_email("Matt@dome3d.com", "Matt")

# contents.each_with_index do |row, i|
#   send_an_email(email, name) if name = "Mike Farr"
# #next if i < 59
#
#   name        = row[:name]
#   email       = row[:email_address]
#   send_an_email(email, name)
#
#   #   puts "#{email}, and #{name}, and #{planetarium}"
# end

#
#   puts name
# end