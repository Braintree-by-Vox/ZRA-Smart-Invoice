Gem::Specification.new do |spec|
  spec.name          = "braintree-theme"
  spec.version       = "0.1.0"
  spec.authors       = ["Your Name"]
  spec.email         = ["your.email@example.com"]

  spec.summary       = "A Jekyll theme"
  spec.homepage      = "https://github.com/Braintree-by-Vox/Braintree-theme"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r{^(_(includes|layouts|sass)|assets|LICENSE|README)}i)
  end

  spec.add_runtime_dependency "jekyll", "~> 4.0"
end