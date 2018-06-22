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
    _get_graph(records, 'bar')
  end

  private
  def _get_graph(data, type)
    if type == 'bar'
      Gchart.bar(data: data.values, axis_with_labels: %w[x y],
                 size: '300x200', axis_labels: [data.keys],
                 axis_range: [[0, 0], [0, data.values.max, 1]])
    end
  end
end