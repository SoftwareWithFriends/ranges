module TimeExtensions
  def within?(range)
    range.start_time <= self && range.end_time >= self
  end
end
