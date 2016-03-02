require 'slack_inviter/version'
require 'net/http'
require 'json'

module SlackInviter
  class Configuration
    attr_accessor :team, :token
  end

  class SlackInviterError < StandardError
  end

  def self.invite(email)
    uri = URI.parse "https://#{@configuration.team}.slack.com/api/users.admin.invite"

    api_response = Net::HTTP.post_form(uri, email: email, token: @configuration.token)
    response = JSON.parse(api_response.body)

    raise SlackInviterError, response['error'] unless response['ok']
    response['ok']
  end

  def self.configure
    @configuration ||= Configuration.new
    yield @configuration
  end
end
