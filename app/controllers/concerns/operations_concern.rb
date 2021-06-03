module OperationsConcern
  def search_and_filter
    find_company
    if params[:query].present?
      @operations = policy_scope(@company.operations)
                                .global_search(params[:query])
                                .order(sort_column + " " + sort_direction)
    else
      @operations = policy_scope(@company.operations)
                                .order(sort_column + " " + sort_direction)
    end

    @invoices = policy_scope(Invoice).order(created_at: :desc)
                                     .where(company_id: @company.id)

    @gains = []
    @operations.each { |operation| @gains << operation.amount if operation.amount > 0 }
    @expenses = []
    @operations.each { |operation| @expenses << operation.amount  if operation.amount < 0 }

    @operations.each do |operation|
      @invoices.each do |invoice|
        if invoice.total_amount == operation.amount.abs
          operation.invoice = invoice
          operation.save!
        end
      end
    end
  end
end
