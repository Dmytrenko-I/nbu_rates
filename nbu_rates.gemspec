# frozen_string_literal: true

require_relative "lib/nbu_rates/version"

Gem::Specification.new do |spec|
  spec.name = "nbu_rates"
  spec.version = NbuRates::VERSION
  spec.authors = ["Ivan Dmytrenko"]
  spec.email = ["dmytrenko.i.t@gmail.com"]

  spec.summary = "Fetches currency rates from https://bank.gov.ua/"
  spec.description = "Fetches currency rates from https://bank.gov.ua/"
  spec.homepage = "https://github.com/Dmytrenko-I/nbu_rates"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.add_dependency 'money', '~> 6'
  spec.add_dependency 'nokogiri', '~> 1.9'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
