require_relative 'test_helper.rb'

class TimeExtensionsTest < Test::Unit::TestCase
  def test_can_check_if_time_is_within_range
    range = TimeRange.new(utc_time_at(3, 0, 3), utc_time_at(3,0, 5))
    time_in_range = utc_time_at(3,0,4)
    assert time_in_range.within?(range)   
  end

  def test_should_be_within_range_when_equal_to_start_time
    range = TimeRange.new(utc_time_at(3, 0, 3), utc_time_at(3,0, 5))
    time_in_range = utc_time_at(3,0,3)
    assert time_in_range.within?(range)   
  end

  def test_should_be_within_range_when_equal_to_end_time
    range = TimeRange.new(utc_time_at(3, 0, 3), utc_time_at(3,0, 5))
    time_in_range = utc_time_at(3,0,5)
    assert time_in_range.within?(range)   
  end

  def test_should_not_be_within_range
    range = TimeRange.new(utc_time_at(3, 0, 3), utc_time_at(3,0, 5))
    time_not_in_range = utc_time_at(3,0,2)
    assert !time_not_in_range.within?(range)
  end

  def test_should_not_be_within_range_when_time_is_after_range_end
    range = TimeRange.new(utc_time_at(3, 0, 3), utc_time_at(3,0, 5))
    time_not_in_range = utc_time_at(3,0,6)
    assert !time_not_in_range.within?(range)
  end
end
