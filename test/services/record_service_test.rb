require 'test_helper'

class RecordServiceTest < ActiveSupport::TestCase
  setup do
    @record_service = RecordService.new
  end

  test 'should return in right order' do
    params = {sort_by: 'title:DESC'}
    expected_output = [records(:two), records(:one)]
    assert_equal(@record_service.get_all_records(params), expected_output,
                 'Data is not ordered correctly')
  end

  test 'should return graph image url' do
    params = { artist: records(:one).artist }
    expected_url = 'http://chart.apis.google.com/chart?chxl=0:|1990&chxt=x,y&chd=s:9&cht=bvs&chs=300x200&chxr=0,0,0|1,0,1,1'
    assert_equal(@record_service.get_artist_graph_data(params), expected_url, 'Does not return image url')
  end
end