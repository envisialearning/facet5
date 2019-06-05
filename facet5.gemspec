
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "facet5/version"

Gem::Specification.new do |spec|
  spec.name          = "facet5"
  spec.version       = Facet5::VERSION
  spec.authors       = ["Nikki Tolentino", "Aldwin Ibuna"]
  spec.email         = ["nikki@envisialearning.com", "aldwin@envisialearning.com"]

  spec.summary       = %q{API Interface for Facet5 API}
  spec.description   = %q{API Interface for Facet5 API}
  spec.homepage      = "https://github.com/envisialearning/facet5"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/envisialearning/facet5"
    spec.metadata["changelog_uri"] = "https://github.com/envisialearning/facet5"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "irb"

  spec.add_dependency 'her'
  spec.add_dependency 'faraday' #, '~> 0.15.4'
  spec.add_dependency 'faraday_middleware' #, '~> 0.13.1'
end