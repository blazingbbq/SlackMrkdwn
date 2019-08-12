# MarkdownToSlackFormatter

Converts markdown to Slack's internal format 'mrkdwn' (See Slack API docs: https://api.slack.com/docs/message-formatting).

# Usage

```ruby
require 'SlackMrkdwn'

slack_formatted_text = SlackMrkdwn.from('My markdown formatted text')
```

_Note:_ Requires Ruby version above or equal to v2.4.6 (because it uses `match?`).

# What is being converted?

It will first encode Slack's restricted characters to HTML entities (`<`, `>` and `&`). Then it will convert:

- Italics emphasis
- Strong emphasis
- Strike-through
- Headings (to bold text)
- Codeblocks
- Indentation
- Unordered lists
- Links (Classic-style and reference-style)

It will also strip any whitespace on either side once it's done the conversion.

### What isn't converted?

These elements do not need to be converted, either because Slack's style is the same or because Slack handles it by default.

- Single line `codeblocks`
- Blockquotes
- Links on their own

# Contributing

### Testing

To run the test suite, execute:

```sh
rake test
```
