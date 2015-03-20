Gem::Specification.new do |s|
  s.name = 'activerecord-create_decorator'
  s.version = '0.1.0.0'
  s.author = 'Team Nemo'
  s.email = 'nemo-engg@godaddy.com'
  s.summary = 'Applies connection-specific options when creating tables through ActiveRecord'
  s.description = 'See summary'
  s.homepage = 'https://github.secureserver.net/PC/activerecord-create_decorator'
  s.files = Dir['lib/**'] + ['README.md']

  s.add_dependency             "activerecord", ">= 3.2"
end
