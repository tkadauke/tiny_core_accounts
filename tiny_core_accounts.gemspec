Gem::Specification.new do |s| 
  s.platform  =   Gem::Platform::RUBY
  s.name      =   "tiny_core_accounts"
  s.version   =   "0.0.1"
  s.date      =   Date.today.strftime('%Y-%m-%d')
  s.author    =   "Thomas Kadauke"
  s.email     =   "tkadauke@imedo.de"
  s.summary   =   "Simple account management based on tiny_core_users"
  s.files     =   Dir.glob("{lib,rails_generators}/**/*")

  s.require_path = "lib"
end
