require 'csv'

class ImportOperationsFromCsv
  attr_reader :csv
  def initialize
    filepath = Rails.root + 'db/countify_operations_seed.csv'
    csv_options = { col_sep: ';', headers: true }
    @csv = CSV.read(filepath, csv_options)
  end

  def call
    puts "Lancement de l'import des opérations contenues dans /db/operations.csv => #{@csv.size} lignes à traiter...🤞"
    @csv.each_with_index do |row, index|
      puts "Traitement de la ligne n°#{index}..."

      operation = Operation.new()
      p row[0]
      p row[-1]
      account = Account.find_by(account_name: row[-1])
      operation.date = Date.parse(row[0])
      operation.amount = row[1].to_i
      operation.details = row[2]
      operation.account = account
      operation.category = row[3]
      operation.save!
      # payment = Payment.new(
      #   # ...
      # )
      # payment.save!
      puts "Traitement de la ligne n°#{index} terminé"
    end
    puts "🎉 Import des operations terminé!"
  end
end
