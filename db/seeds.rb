# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "destroying existing records..."
User.destroy_all
Invoice.destroy_all
Operation.destroy_all
Account.destroy_all
Company.destroy_all
Accountant.destroy_all


puts "destroying existing records DONE"

puts "creating accountant ..."

accountant = Accountant.create(name: "Super-Comptable")

puts "accountant DONE creating user ..."

user = User.create(accountant: accountant, first_name:"Stéphane", last_name: "De Courcel", email:"steph@mail.com", password:"123456")

puts "User DONE creating company ..."

company = Company.create(accountant: accountant, name: "Vibrary", siren: "897897906", siret: "89789790600011", fiscal_regim: "SARL", address:"Villa Gaudelet, Paris", phone_number:"0111236677")
puts "Company DONE creating account ..."

account = Account.create(iban: "FR5230003000509811414747Q31", swift: "AGFBFRCC", account_name: "Pro 1", company: company)

puts "Account DONE creating operations ..."

ImportOperationsFromCsv.new(account).call

puts "Operations DONE creating invoices ..."

ImportInvoicesFromCsv.new(company).call

puts "invoices DONE"
