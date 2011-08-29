require_relative 'test_helper.rb'

class DateExtensionsTest < Test::Unit::TestCase

  def test_can_check_if_date_is_within_range
    range = TimeRange.new(utc_time_at(3, 0, 3), utc_time_at(3,0, 5))
    date_in_range = utc_time_at(3,0,4).to_date
    assert date_in_range.within?(range)   
  end

  def test_should_be_within_range_when_equal_to_start_date
    range = TimeRange.new(utc_time_at(3, 0, 3), utc_time_at(3,0, 5))
    date_in_range = utc_time_at(3,0,3).to_date
    assert date_in_range.within?(range)   
  end

  def test_should_be_within_range_when_equal_to_end_date
    range = TimeRange.new(utc_time_at(3, 0, 3), utc_time_at(3,0, 5))
    date_in_range = utc_time_at(3,0,5).to_date
    assert date_in_range.within?(range)   
  end

  def test_should_not_be_within_range
    range = TimeRange.new(utc_time_at(3, 0, 3), utc_time_at(3,0, 5))
    date_not_in_range = utc_time_at(3,0,2).to_date
    assert !date_not_in_range.within?(range)
  end

  def test_should_not_be_within_range_when_date_is_after_range_end
    range = TimeRange.new(utc_time_at(3, 0, 3), utc_time_at(3,0, 5))
    date_not_in_range = utc_time_at(3,0,6).to_date
    assert !date_not_in_range.within?(range)
  end
end
