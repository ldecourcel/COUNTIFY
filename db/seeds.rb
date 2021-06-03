# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "destroying existing records..."
Message.destroy_all
User.destroy_all
Invoice.destroy_all
Operation.destroy_all
Account.destroy_all
Chat.destroy_all
Company.destroy_all
Accountant.destroy_all


puts "destroying existing records DONE"

puts "creating accountant ..."

accountant = Accountant.create(name: "Super-Comptable")

puts "accountant DONE creating user ..."

user = User.create(accountant: accountant, first_name:"Stéphane", last_name: "De Courcel", email:"steph@mail.com", password:"123456")

puts "User DONE creating company ..."

company1 = Company.create(accountant: accountant, name: "Vibrary", siren: "897897906", siret: "89789790600011", fiscal_regim: "SARL", address:"Villa Gaudelet, Paris", phone_number:"0111236677")

company2 = Company.create(accountant: accountant, name: "Georgie", siren: "895207906", siret: "89520790600231", fiscal_regim: "EI", address:"Place Vendome, Paris", phone_number:"0111236676")

user_client = User.create(company: company1, first_name:"Agathe", last_name: "Auriol", email:"agathe@vibrary.com", password:"123456")

companies = [ company1, company2 ]
puts "Company DONE creating chats ..."

chat1 = Chat.create(name: "#Messages", company: company1, accountant: accountant)
chat2 = Chat.create(name: "#Messages", company: company2, accountant: accountant)
puts "Chat DONE creating account ..."


account1_company1 = Account.create(iban: "FR5230003000509811414747Q31", swift: "AGFBFRCC", account_name: "BNP", company: company1)
account2_company1 = Account.create(iban: "FR5230003000509811414747Q32", swift: "AGFBFRCC", account_name: "HSBC", company: company1)

account1_company2 = Account.create(iban: "FR5230003000509811414747Q33", swift: "AGFBFRCD", account_name: "BRED", company: company2)
account2_company2 = Account.create(iban: "FR5230003000509811414747Q34", swift: "AGFBFRCD", account_name: "BNP", company: company2)

accounts = [ account1_company1, account2_company1, account1_company2, account2_company2 ]

puts "Account DONE creating operations ..."

ImportOperationsFromCsv.new.call

puts "Operations DONE creating invoices ..."


ImportInvoicesFromCsv.new.call

puts "invoices DONE"
