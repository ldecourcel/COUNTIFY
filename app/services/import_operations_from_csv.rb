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
      attributes = row.to_h.transform_keys do |key|
        if key == "﻿date"
          key = "date"
        end
        key.to_sym
      end
      Operation.create!(attributes)
      # payment = Payment.new(
      #   # ...
      # )
      # payment.save!
      puts "Traitement de la ligne n°#{index} terminé"
    end
    puts "🎉 Import des users terminé!"
  end
end