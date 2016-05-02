# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'atspi/version'

Gem::Specification.new do |spec|
  spec.name          = "atspi"
  spec.version       = ATSPI::VERSION
  spec.authors       = ["Christopher Aue"]
  spec.email         = ["mail@christopheraue.net"]

  spec.description   = %q{The atspi gem lets you comfortably call the Assistive Technology Service Provider Interface (AT-SPI) on Linux.}
  spec.summary       = %q{A high level wrapper around libatspi.}
  spec.homepage      = "https://github.com/christopheraue/ruby-atspi"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "gir_ffi", "~> 0.10.0"
  spec.add_dependency "ruby-dbus", "~> 0.11.0"
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "yard", "~> 0.8"
end
