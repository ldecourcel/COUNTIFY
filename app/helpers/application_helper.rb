module ApplicationHelper
  def sortable(column, title = nil)
    column_downcase = column.downcase
    # css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = (sort_direction == "asc") ? "desc" : "asc"
    # link_to title, company_operations_path(@company), { :sort => column_downcase, :direction => direction,  data: { sorting_target: 'button', action: 'click->sorting#fetch' }}
    link_to title, company_operations_path(@company),
                   { direction: direction,
                     data: { sorting_target: 'button', action: 'click->sorting#fetch', sort: column_downcase }
                   }
  end

  def sortable_invoice(column, title = nil)
    column_downcase = column.downcase
    # css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = (sort_direction == "asc") ? "desc" : "asc"
    link_to title,  { :sort => column_downcase, :direction => direction }
  end
end
