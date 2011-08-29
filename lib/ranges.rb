require_relative 'time_range.rb'
require_relative 'date_extensions.rb'
require_relative 'time_extensions.rb'

class Date
  include DateExtensions
end

class Time
  include TimeExtensions
end

