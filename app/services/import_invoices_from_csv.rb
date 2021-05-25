require 'csv'

class ImportInvoicesFromCsv
  attr_reader :csv
  def initialize(company)
    filepath = Rails.root + 'db/countify_invoices_seed.csv'
    csv_options = { col_sep: ';', headers: true }
    @csv = CSV.read(filepath, csv_options)
    @company = company
  end
  def call
    puts "Lancement de l'import des opérations contenues dans /db/operations.csv => #{@csv.size} lignes à traiter...🤞"
    @csv.each_with_index do |row, index|
      puts "Traitement de la ligne n°#{index}..."
      # p row.to_h.class
      r = row.to_h
      r.transform_keys! do |key|
        # p key
        if key.include?("date")
          key = :date
          # p key
        end
        key.to_sym
      end

      # p r

      invoice = Invoice.new(r)
      # p invoice
      # p row[0]
      invoice.date = Date.parse(row[0])
      # p invoice

      # invoice.amount = row[1]
      # invoice.details = row[2]
      invoice.company = @company
      invoice.save!
      # payment = Payment.new(
      #   # ...
      # )
      # payment.save!
      puts "Traitement de la ligne n°#{index} terminé"
    end
    puts "🎉 Import des invoices terminé!"
  end
end