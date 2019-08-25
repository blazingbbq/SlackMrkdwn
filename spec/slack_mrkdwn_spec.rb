require 'rspec'
require 'slack_mrkdwn'

describe SlackMrkdwn do
  Test = Struct.new(:description, :source, :expectation)

  tests = [
    Test.new('encodes Slack\'s restricted characters', '<Restricted&Characters>', '&lt;Restricted&amp;Characters&gt;'),
    Test.new('removes trailing whitespace', "Hello, World!\n  \n\t\n", 'Hello, World!'),

    Test.new('converts emphasis', '*Asterisk* and _underscore_ emphasis', '_Asterisk_ and _underscore_ emphasis'),
    Test.new('converts strong emphasis', '**Asterisk** and __underscore__ strong emphasis', '*Asterisk* and *underscore* strong emphasis'),
    Test.new('converts combined emphasis', 'Combined emphasis with **asterisks and _underscores_**.', 'Combined emphasis with *asterisks and _underscores_*.'),
    Test.new('converts strike-through', '~~Crossed out~~ content', '~Crossed out~ content'),
    Test.new('converts codeblocks', "```javascript\nconsole.log('Hello, World!')\n```", "```\nconsole.log('Hello, World!')\n```"),
    Test.new('converts unordered lists', "+ List with plus symbol\n* Or asterisk\n- Or minus symbol\n\t+ Even indented lists", "- List with plus symbol\n- Or asterisk\n- Or minus symbol\n   - Even indented lists"),
    Test.new('converts ordered lists', "1. First element\n1. Second element\n1. Third element", "1. First element\n2. Second element\n3. Third element"),
    Test.new('converts nested lists', "1. First element\n   1. Nested element\n   1. Another nested element\n1. Second element\n1. Third element", "1. First element\n   1. Nested element\n   2. Another nested element\n2. Second element\n3. Third element"),
    Test.new('converts image', "![](https://example.com/image.png)", 'https://example.com/image.png'),
    Test.new('converts image with text', "![ignored](https://example.com/image.png)", 'https://example.com/image.png'),
    Test.new('converts classic-style links', '[Classic-style link](https://www.google.com)', '<https://www.google.com|Classic-style link>'),
    Test.new('converts classic-style links with alt text', '[Classic-style link](https://www.google.com "With alt text")', '<https://www.google.com|Classic-style link>'),
    Test.new('converts reference-style links', "[Reference-style link][2]\n[2]: https://www.google.com", '<https://www.google.com|Reference-style link>'),
    Test.new('converts reference-style, text only links', "[Reference-style link, text only]\n[reference-style link, text only]: https://www.google.com", '<https://www.google.com|Reference-style link, text only>'),

    Test.new('preserves code spans', 'My `codespan` should be preserved...', 'My `codespan` should be preserved...'),
    Test.new('preserves leading spaces', "   Aligned text content", "   Aligned text content"),
    Test.new('preserves paragraphs', 'My paragraph looks the same!', 'My paragraph looks the same!'),
    Test.new('preserves spacing between paragraphs', "My first paragraph!\n\nFollowed by another paragraph!", "My first paragraph!\n\nFollowed by another paragraph!"),
    Test.new('preserves spacing between lists and paragraphs', "Description of list:\n\n* List Element\n+ Another list element\n\nFollow up paragraph.", "Description of list:\n\n- List Element\n- Another list element\n\nFollow up paragraph."),
  ]

  tests.each do |t|
    it t[:description] do
      expect(SlackMrkdwn.from(t[:source])).to eq(t[:expectation])
    end
  end

  Dir.glob('spec/fixtures/source/**/*') do |source_file|
    next if File.directory? source_file
    
    it "Integration: #{source_file}" do
      expectation_file = "#{source_file.gsub(/\/source\/(.*?)$/, '/expectation/\1')}_expectation"
      
      begin
        source = File.read(source_file)
        expectation = File.read(expectation_file)
      rescue
        fail
      end

      expect(SlackMrkdwn.from(source)).to eq(expectation)
    end
  end
end
