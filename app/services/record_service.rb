require 'googlecharts'

class RecordService
  def get_all_records(params)
    sort_by = 'title'
    sort_order = 'asc'
    if params[:sort_by].present?
      sort_by = params[:sort_by].split(':')[0]
      sort_order = params[:sort_by].split(':')[1]
    end
    Record.order("#{sort_by} #{sort_order}")
  end

  def get_artist_graph_data(params)
    records = Record.where(artist: params[:artist]).group(:year).count
    Gchart.bar(:data => records.values, :axis_with_labels => ['x', 'y'], :size => '300x200', :axis_labels => [records.keys], :axis_range => [[0,0],[0,records.values.max,1]])
  end
end