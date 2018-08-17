# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "lurn"
  spec.version       = "0.1.2"
  spec.authors       = ["daniel.carpenter"]
  spec.email         = ["daniel.carpenter01@gmail.com"]

  spec.summary       = %q{ A gem with tools for machine learning. }
  spec.description   = %q{ A gem with tools for machine learning. }
  spec.homepage      = "https://www.github.com/dansbits/lurn"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "terminal-table", "~> 1.8.0"
  spec.add_dependency "ruby-stemmer", "~> 0.9.6"
  spec.add_dependency "daru", "~> 0.2.1"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rspec_junit_formatter"
  spec.add_development_dependency "yard", "~> 0.9.9"
end
