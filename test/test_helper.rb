require 'test/unit'
require_relative '../lib/ranges.rb'

def utc_time_at(hour = 6, min = 0, day = 5, month = 10, year = 2010, sec = 0)
  Time.utc(year, month, day, hour, min, sec)
end
