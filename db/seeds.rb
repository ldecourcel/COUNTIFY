# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

accountant = Accountant.create(name: "Super-Comptable")

user = User.crate(accountant: accountant, first_name:"Stéphane", last_name: "De Courcel", username:"Steph", email:"steph@mail.com", password:"123456")

company = Company.create(accountant: accountant, siren: "897897906", siret: "89789790600011", fiscal_regim: "SARL", address:"Villa Gaudelet, Paris", phone_number:"0111236677")

Account.create(iban: "FR5230003000509811414747Q31", swift: "AGFBFRCC", name: "Pro 1", account: compa)