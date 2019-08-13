Gem::Specification.new do |s|
  s.name        = 'slack_mrkdwn'
  s.version     = '1.0.0'
  s.date        = '2019-08-12'
  s.summary     = "Convert markdown to Slack's message format 'mrkdwn'."
  s.description = "Convert markdown to Slack's message format 'mrkdwn'."
  s.authors     = ["Simon Cousineau"]
  s.email       = 'simon.cousineau99@gmail.com'
  s.files       = ["lib/slack_mrkdwn.rb"]
  s.homepage    = 'https://github.com/BlazingBBQ/SlackMrkdwn'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.4.6'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end