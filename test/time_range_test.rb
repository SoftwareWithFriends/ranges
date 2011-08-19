require 'test/unit'
require_relative '../lib/time_range.rb'

class TimeRangeTest < Test::Unit::TestCase

  def test_create_time_range_with_times
    starts = utc_time_at(3)
    ends = utc_time_at(4)
    range = TimeRange.new(starts, ends)
    assert_equal starts, range.start_time
    assert_equal ends, range.end_time
  end

  def test_requires_start_time_to_be_time
    assert_raise ArgumentError do
      TimeRange.new(1, utc_time_at(1))
    end
  end

  def test_requires_end_time_to_be_time
    assert_raise ArgumentError do
      TimeRange.new(utc_time_at(1), 1)
    end
  end

  def test_error_message
    e = assert_raise ArgumentError do
      TimeRange.new(1, 1)
    end
    assert_equal "Parameters must be time objects", e.message
  end

  def test_should_not_overlap
    given_disjoint_ranges do |earlier, later|
      assert !(earlier.overlaps_with?(later))
      assert !(later.overlaps_with?(earlier))
    end
  end

  def test_should_overlap_if_one_range_ends_or_starts_inside_another
    given_staggered_ranges do |earlier, later|
      assert (earlier.overlaps_with?(later))
      assert (later.overlaps_with?(earlier))
    end
  end

  def test_should_overlap_if_one_range_is_contained_within_another
    given_nested_ranges do |outer, inner|
      assert (outer.overlaps_with?(inner))
      assert (inner.overlaps_with?(outer))
    end
  end

  def test_should_overlap_if_ranges_equal
    range = TimeRange.new(utc_time_at(3), utc_time_at(4))
    assert range.overlaps_with?(range)
  end

  def test_should_not_be_within_other_range_when_disjoint
    given_disjoint_ranges do |earlier, later|
      assert !earlier.within?(later)
      assert !later.within?(earlier)
    end
  end

  def test_should_not_be_within_other_range_when_staggered
    given_staggered_ranges do |earlier, later|
      assert !earlier.within?(later)
      assert !later.within?(earlier)
    end
  end

  def test_should_be_within_other_range
    given_nested_ranges do |outer, inner|
      assert inner.within?(outer)
    end
  end

  def test_should_not_be_within_inner_range
    given_nested_ranges do |outer, inner|
      assert !outer.within?(inner)
    end
  end

  def test_should_not_wrap_other_range_when_disjoint
    given_disjoint_ranges do |earlier, later|
      assert !earlier.wraps?(later)
      assert !later.wraps?(earlier)
    end
  end

  def test_should_not_wrap_other_range_when_staggered
    given_staggered_ranges do |earlier, later|
      assert !earlier.wraps?(later)
      assert !later.wraps?(earlier)
    end
  end

  def test_should_not_wrap_other_range
    given_nested_ranges do |outer, inner|
      assert !inner.wraps?(outer)
    end
  end

  def test_should_wrap_inner_range
    given_nested_ranges do |outer, inner|
      assert outer.wraps?(inner)
    end
  end

  def test_should_not_be_disjoint
    given_staggered_ranges do |earlier, later|
      assert !earlier.disjoint_to?(later)
      assert !later.disjoint_to?(earlier)
    end
  end

  def test_should_be_disjoint
    given_disjoint_ranges do |earlier, later|
      assert earlier.disjoint_to?(later)
      assert later.disjoint_to?(earlier)
    end
  end

  private
  def given_nested_ranges
    outer = TimeRange.new(utc_time_at(7), utc_time_at(10))
    inner = TimeRange.new(utc_time_at(8), utc_time_at(9))
    yield(outer, inner) 
  end

  def given_staggered_ranges
    earlier = TimeRange.new(utc_time_at(7), utc_time_at(9))
    later = TimeRange.new(utc_time_at(8), utc_time_at(10))
    yield(earlier, later)
  end

  def given_disjoint_ranges
    earlier = TimeRange.new(utc_time_at(7), utc_time_at(8))
    later = TimeRange.new(utc_time_at(8), utc_time_at(10))
    yield(earlier, later)
  end

  def utc_time_at(hour = 6, min = 0, day = 5, month = 10, year = 2010)
    Time.utc(year, month, day, hour, min)
  end
end