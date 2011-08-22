
class TimeRange
  attr_reader :start_time, :end_time
  def initialize(start_time, end_time)
    unless start_time.is_a?(Time) && end_time.is_a?(Time)
      raise ArgumentError.new("Parameters must be time objects")
    end
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
end
