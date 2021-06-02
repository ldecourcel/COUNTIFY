module ApplicationHelper
  def sortable(column, title = nil)
    column_downcase = column.downcase
    # css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = (sort_direction == "asc") ? "desc" : "asc"
    link_to title, {:sort => column_downcase, :direction => direction, anchor: 'panel'}
  end

end
