# MarkdownToSlackFormatter
Converts markdown to Slack's internal format 'mrkdwn' (See Slack API docs: https://api.slack.com/docs/message-formatting).

# Usage
``` ruby
require 'SlackMrkdwn'

slack_formatted_text = SlackMrkdwn.from('My markdown formatted text')
```

# Contributing

### Testing
To run the test suite, execute:
``` sh
rake test
```
