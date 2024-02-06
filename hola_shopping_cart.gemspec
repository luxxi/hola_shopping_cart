lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = "hola_shopping_cart"
  spec.version = "0.4"
  spec.authors = ["Luka Domitrovic"]
  spec.email = ["luka@domitrovic.si"]

  spec.summary = "Hola Shopping Cart CLI app"
  spec.description = <<-TEXT
  Are you tired of shopping on over-designed webshops?  
  Hola Shopping Cart is a simple, eyes-friendly CLI application to browse 
  products and fill the shopping cart. 
  Don't leave your favorite terminal to go shopping. 
  It's an example app for a technical assignment ;)
  TEXT
  spec.license = "MIT"
  spec.homepage = "https://rubygems.org/gems/hola_shopping_cart"

  spec.files = Dir["{lib}/**/*.rb", "bin/*", "*.md"]
  spec.require_path = "lib"

  spec.executables = ["hola"]

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/luxxi/hola_shopping_cart"

  spec.required_ruby_version = "~> 3.0"

  spec.add_runtime_dependency "tty-prompt", "~> 0.23.1"
  spec.add_runtime_dependency "tty-table", "~> 0.12.0"
  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "rspec-uuid", "~> 0.5.0"
  spec.add_development_dependency "rubocop", "~> 1.60.2"
end
