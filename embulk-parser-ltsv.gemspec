
Gem::Specification.new do |spec|
  spec.name          = "embulk-parser-ltsv"
  spec.version       = "0.1.0"
  spec.authors       = ["Hirokazu Hata"]
  spec.summary       = "Ltsv parser plugin for Embulk"
  spec.description   = "Parses Ltsv files read by other file input plugins."
  spec.email         = ["h.hata.ai.t@gmail.com"]
  spec.licenses      = ["MIT"]
  spec.homepage      = "https://github.com/h.hata.ai.t/embulk-parser-ltsv"

  spec.files         = `git ls-files`.split("\n") + Dir["classpath/*.jar"]
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'embulk', ['~> 0.7.2']
  spec.add_development_dependency 'bundler', ['~> 1.0']
  spec.add_development_dependency 'rake', ['>= 10.0']
end
