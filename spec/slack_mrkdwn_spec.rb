require 'rspec'
require 'slack_mrkdwn'

describe SlackMrkdwn do
  Test = Struct.new(:description, :source, :expectation)

  tests = [
    Test.new('encodes Slack\'s restricted characters', '<Restricted&Characters>', '&lt;Restricted&amp;Characters&gt;')
  ]

  tests.each do |t|
    it t[:description] do
      expect(SlackMrkdwn.from(t[:source])).to eq(t[:expectation])
    end
  end

  it 'integration test' do
    markdown_fixture = File.read('spec/fixtures/markdown_fixture.txt')
    expectation_fixture = File.read('spec/fixtures/expectation_fixture.txt')

    expect(SlackMrkdwn.from(markdown_fixture)).to eq(expectation_fixture)
  end
end