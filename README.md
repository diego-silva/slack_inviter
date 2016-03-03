# SlackInviter

[![Build Status](https://travis-ci.org/diego-silva/slack_inviter.svg?branch=master)](https://travis-ci.org/diego-silva/slack_inviter)
[![Code Climate](https://codeclimate.com/github/diego-silva/slack_inviter/badges/gpa.svg)](https://codeclimate.com/github/diego-silva/slack_inviter)
[![Coverage Status](https://coveralls.io/repos/github/diego-silva/slack_inviter/badge.svg?branch=master)](https://coveralls.io/github/diego-silva/slack_inviter?branch=master)

Easily automate your Slack team invitations.

Use this gem with you Rails, Sinatra or any Ruby application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack_inviter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slack_inviter

## Configuration

Before inviting your new users you need to configure the SlackInviter with you team and API token using the following script:

```ruby
SlackInviter.configure do |config|
  config.team = 'team_domain'
  config.token = 'api_token'
end
```

If you are using Rails we recommend adding the above script to `config/initializers/slack_inviter.rb`.

Make sure you fill the configurations above with the proper values for your Slack team.

You can get more information on generating a Slack API token on [Slack's Help Center](https://get.slack.help/hc/en-us/articles/215770388-Creating-and-regenerating-API-tokens).


## Usage

```ruby
SlackInviter.invite('me@example.com') # => true
```

If everything goes well you should expect the above command to return `true`, otherwise it will raise a `SlackInviterError` that inherits from Ruby's `StandardError`.

The `SlackInviterError` message will contain the error returned by the Slack API and can be used to understand what happened.
Currently it may be one of the following:

- `already_in_team` - User is already a member
- `already_invited` - User haven't accepted the invitation yet
- `invalid_email` - The email provided was considered invalid
- `invalid_auth` - The token provided for this team is not valid

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/diego-silva/slack_inviter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
