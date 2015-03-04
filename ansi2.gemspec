require_relative 'lib/ansi2'

Gem::Specification.new do |s|
	s.name = 'ansi2'
	s.version = ANSI2::VERSION
	s.authors = ['Colin MacKenzie IV', 'Aaron Ten Clay']
	s.email = %w(sinisterchipmunk@gmail.com aarontc@aarontc.com)
	s.summary = %q{Handles every aspect (that I could think of) of dealing with ANSI escape sequences.}
	s.description = %q{Handles every aspect (that I could think of) of dealing with ANSI escape sequences.}
	s.homepage = 'https://aarontc.com/projrects/ansi2'
	s.license = 'MIT'

	s.files = `git ls-files -z`.split("\x0")
	s.executables = s.files.grep(%r{^bin/}) { |f| File.basename f }
	s.test_files = s.files.grep(%r{^(test|spec|features)/})
	s.require_paths = ['lib']

	s.add_dependency 'require_all'

	s.add_development_dependency 'bundler', '~> 1.7'
	s.add_development_dependency 'rake', '~> 10.0'
	s.add_development_dependency 'minitest', '~> 5.5'
	s.add_development_dependency 'minitest-spec-context'
end
