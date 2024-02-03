lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = "hola"
  spec.version = "0.1"
  spec.authors = ["Luka Domitrovic"]
  spec.email = ["luka@domitrovic.si"]

  spec.summary = "Hola Shopping Cart CLI app"
  spec.description = "Interactive CLI application for Hola Shopping Cart"
  spec.license = "MIT"
  spec.homepage = "https://rubygems.org/gems/hola_shopping_cart"

  spec.files = Dir["{lib}/**/*.rb", "bin/*", "*.md"]
  spec.require_path = "lib"

  spec.required_ruby_version = "~> 3.0"

  spec.add_runtime_dependency "tty-prompt", "~> 0.23.1"
  spec.add_runtime_dependency "tty-table", "~> 0.12.0"
  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "rubocop", "~> 1.60.2"
end
