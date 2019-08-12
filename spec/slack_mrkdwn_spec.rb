require 'rspec'
require 'slack_mrkdwn'

describe SlackMrkdwn do
  Test = Struct.new(:description, :source, :expectation)

  tests = [
    Test.new('encodes Slack\'s restricted characters', '<Restricted&Characters>', '&lt;Restricted&amp;Characters&gt;'),
    Test.new('converts emphasis', '*Asterisk* and _underscore_ emphasis', '_Asterisk_ and _underscore_ emphasis'),
    Test.new('converts strong emphasis', '**Asterisk** and __underscore__ strong emphasis', '*Asterisk* and *underscore* strong emphasis'),
    Test.new('converts combined emphasis', 'Combined emphasis with **asterisks and _underscores_**.', 'Combined emphasis with *asterisks and _underscores*_.'),
    Test.new('converts strike-through', '~~Crossed out~~ content', '~Crossed out~ content'),
    Test.new('converts codeblocks', "```javascript\nconsole.log('Hello, World!')\n```", "```\nconsole.log('Hello, World!')\n```"),
    Test.new('converts leading spaces', '   Aligned text content', '\tAligned text content'), # TODO: Align with actual tabs?
    Test.new('converts unordered lists', "+ List with plus symbol\n* Or asterisk\n- Or minus symbol\n\\t+ Even indented lists", "- List with plus symbol\n- Or asterisk\n- Or minus symbol\n\\t- Even indented lists"),
    Test.new('converts classic-style links', '[Classic-style link](https://www.google.com)', '<https://www.google.com|Classic-style link>'),
    Test.new('converts classic-style links with alt text', '[Classic-style link](https://www.google.com "With alt text")', '<https://www.google.com|Classic-style link>'),
    Test.new('converts reference-style links', "[Reference-style link][2]\n[2]: https://www.google.com", '<https://www.google.com|Reference-style link>'),
    Test.new('converts reference-style, text only links', "[Reference-style link, text only]\n[reference-style link, text only]: https://www.google.com", '<https://www.google.com|Reference-style link, text only>'),
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