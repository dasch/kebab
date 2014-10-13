Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  s.name              = 'kebab'
  s.version           = '0.0.1'
  s.date              = '2014-09-09'

  s.summary     = ""
  s.description = ""
  s.license     = "apache2"

  s.authors  = ["Daniel Schierbeck"]
  s.email    = 'daniel.schierbeck@gmail.com'
  s.homepage = ''

  s.add_dependency('rails', '>= 3.2')
  s.add_development_dependency('rspec-rails', '>= 3.0')

  s.require_paths = %w[lib]

  # = MANIFEST =
  s.files = %w[
  ]
  # = MANIFEST =

  s.test_files = s.files.select { |path| path =~ /^spec\/.*_spec\.rb/ }
end
