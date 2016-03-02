# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack_inviter/version'

Gem::Specification.new do |spec|
  spec.name          = 'slack_inviter'
  spec.version       = SlackInviter::VERSION
  spec.authors       = ['Diego Silva']
  spec.email         = ['diego.silva@live.com']

  spec.summary       = 'Easily automate your Slack team invitations'
  spec.homepage      = 'https://github.com/diego-silva/slack_inviter'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
