
class TimeRange
  TIME_REQUIRED = "Parameters must be time objects"
  START_BEFORE_END = "Start time must come before end time"
  attr_reader :start_time, :end_time

  def initialize(start_time, end_time)
    unless start_time.is_a?(Time) && end_time.is_a?(Time)
      raise ArgumentError.new(TIME_REQUIRED)
    end
    raise ArgumentError.new(START_BEFORE_END) unless start_time < end_time
    @start_time = start_time
    @end_time = end_time
  end

  def overlaps_with?(range)
    range.start_time < end_time && range.end_time > start_time
  end

  def within?(range)
    range.start_time < start_time && range.end_time > end_time
  end

  def wraps?(range)
    range.within?(self)
  end

  def disjoint_to?(range)
    !self.overlaps_with?(range) 
  end

  def starts_before?(range)
    start_time < range.start_time
  end

  def starts_after?(range)
    start_time > range.start_time
  end

  def ends_before?(range)
    end_time < range.end_time
  end

  def ends_after?(range)
    end_time > range.end_time
  end

  def length_in_seconds
    end_time.to_i - start_time.to_i
  end

  def length_in_minutes
    length_in_seconds / 60.0
  end

  def length_in_hours
    length_in_seconds / 3600.0
  end

  def longer_than?(range)
    length_in_seconds > range.length_in_seconds 
  end 
end
