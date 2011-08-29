
module DateExtensions
  def within?(range)
    range.start_date <= self && range.end_date >= self
  end
end
