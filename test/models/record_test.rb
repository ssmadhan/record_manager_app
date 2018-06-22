require 'test_helper'

class RecordTest < ActiveSupport::TestCase
  test 'does not save without title' do
    record = Record.new
    assert_not record.save, "Saved the record without a title"
  end

  test 'does not save without artist' do
    record = Record.new(title: 'title1')
    assert_not record.save, "Saved the record without an artist"
  end

  test 'does not save without year' do
    record = Record.new(title: 'title1', artist: 'artist1')
    assert_not record.save, "Saved the record without a year"
  end

  test 'saves with all valid data' do
    record = Record.new(title: 'title1', artist: 'artist1', year: 1990)
    assert record.save, "Did not save with valid data"
  end
end
