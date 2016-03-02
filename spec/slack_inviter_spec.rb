require 'spec_helper'

describe SlackInviter do
  it 'has a version number' do
    expect(SlackInviter::VERSION).not_to be nil
  end

  before :each do
    SlackInviter.configure do |config|
      config.team = 'exampleteam'
      config.token = 'TOKEN'
    end
  end

  it 'does allow configuration' do
    config = SlackInviter.instance_variable_get('@configuration')
    expect(config.team).to eq 'exampleteam'
    expect(config.token).to eq 'TOKEN'
  end

  it 'does invite user' do
    expect(Net::HTTP).to receive(:post_form).with(URI.parse('https://exampleteam.slack.com/api/users.admin.invite'),
                                                  email: 'me@example.com',
                                                  token: 'TOKEN').and_return(double(body: '{"ok":true}'))

    expect(SlackInviter.invite('me@example.com')).to be_truthy
  end

  context 'when ok is false it does raise exception' do
    it 'fail when user already in team' do
      allow(Net::HTTP).to receive(:post_form).and_return(double(body: '{"ok":false,"error":"already_in_team"}'))
      expect { SlackInviter.invite('me@example.com') }.to raise_error SlackInviter::SlackInviterError, 'already_in_team'
    end

    it 'fail when user alreay invited' do
      allow(Net::HTTP).to receive(:post_form).and_return(double(body: '{"ok":false,"error":"already_invited"}'))
      expect { SlackInviter.invite('me@example.com') }.to raise_error SlackInviter::SlackInviterError, 'already_invited'
    end

    it 'fail when email is invalid' do
      allow(Net::HTTP).to receive(:post_form).and_return(double(body: '{"ok":false,"error":"invalid_email"}'))
      expect { SlackInviter.invite('me@example.com') }.to raise_error SlackInviter::SlackInviterError, 'invalid_email'
    end

    it 'fail when token is invalid' do
      allow(Net::HTTP).to receive(:post_form).and_return(double(body: '{"ok":false,"error":"invalid_auth"}'))
      expect { SlackInviter.invite('me@example.com') }.to raise_error SlackInviter::SlackInviterError, 'invalid_auth'
    end
  end
end
