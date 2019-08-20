# SlackMrkdwn

[![Build Status](https://travis-ci.com/BlazingBBQ/SlackMrkdwn.svg?branch=master)](https://travis-ci.com/BlazingBBQ/SlackMrkdwn)
[![Gem Version](https://badge.fury.io/rb/slack_mrkdwn.svg)](https://badge.fury.io/rb/slack_mrkdwn)

Converts markdown to Slack's message format 'mrkdwn' (See Slack API docs: https://api.slack.com/docs/message-formatting).

# Installation

Add the gem to your gemfile: `gem 'slack_mrkdwn'`, then run `bundle install`.

Or install the gem by running: `gem install slack_mrkdwn`.

# Usage

```ruby
require 'SlackMrkdwn'

slack_formatted_text = SlackMrkdwn.from('My markdown formatted text')
```

_Note:_ Requires Ruby version above or equal to v1.9.2 (because it uses Redcarpet to render Markdown).

# What is being converted?

It will first encode Slack's restricted characters to HTML entities (`<`, `>` and `&`). Then it will convert:

- Italics emphasis
- Strong emphasis
- Strike-through
- Headings (to bold text)
- Codeblocks
- Single line `codeblocks`
- Blockquotes
- Unordered lists
- Ordered lists
- Images
- Links (Classic-style and reference-style)

It will also strip any trailing whitespace once it's done the conversion.

# Contributing

### Testing

To run the test suite, execute:

```sh
rake test
```
