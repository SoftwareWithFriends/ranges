Gem::Specification.new do |s|
  s.name = "ranges"
  s.version = "0.1.0"
  s.authors = ["Peter Zimbelman"]
  s.summary = "Ranges: A gem for time and date ranges."
  s.email = "pzimbelman@gmail.com"
  s.homepage = "http://github.com/softwarewithfriends/ranges"
  s.description = "Ranges is a gem which supplies a time/date range class and other functionality based around these ranges."
  s.required_rubygems_version = ">= 1.3.6"
  s.files  = Dir.glob("{lib}/**/*") << "README"
  s.require_path = 'lib'
end
