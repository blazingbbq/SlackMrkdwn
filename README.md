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

### Integration tests

The test runner reads integration test fixtures from the `spec/fixtures` directory. To add a new integration test fixture:

- Add the markdown formatted text content in the `spec/fixtures/source` directory
- Add a corresponding expectation fixture in the `spec/fixtures/expectation` directory

The expectation fixture should have the same name as the source fixture and end with `_expectation`.

The test runner supports a nested file structure for the fixture directories.
For example, adding the source fixture `spec/fixtures/source/my_org_name/integration_fixture`, would test it against the expectation fixture found in `spec/fixtures/expectation/my_org_name/integration_fixture_expecation`.

Source fixtures that do not have a corresponding expectation fixture will log a test failure.

# Changelog

### 2.2.0

- Fixed paragraph and list spacing
- Added better integration test support

### 2.1.0

- Added list support

### 2.0.0

- Now using Redcarpet markdown renderer to convert text.
