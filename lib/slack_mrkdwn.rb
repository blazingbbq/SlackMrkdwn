module SlackMrkdwn
  def self.from(markdown)
    markdown
      .gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;') # Encode Slack restricted characters
      .gsub(/\*(.*?)\*/, '_\1_') # Emphasis
      .gsub(/\*{2}(.+?)\*{2}/, '*\1*').gsub(/_{2}(.+?)_{2}/, '*\1*') # Strong emphasis
      .gsub(/~{2}(.+?)~{2}/, '~\1~') # Strike-through
      .gsub(/^\#{1,6} (.+?)$/, '*\1*').gsub(/(.*?)\n^=+$/, '*\1*').gsub(/(.*?)\n^-+$/, '*\1*') # Headings
      .gsub(/`{3}\w*(.*?)`{3}/m, '```\1```') # Codeblock
      .gsub(/^ +/, '\t') # Leading spaces
      .gsub(/^((?:\\t)*?)[\*\+-] (.+)/, '\1- \2') # Unordered lists
      .gsub(/\[(.+?)\]\((.+?)(?: .*?)?\)/, '<\2|\1>') # Classic link
      .gsub(/\[(.+?)\]\[(.+?)\]/) { |m| markdown.match?(/\[#{$2}\]: (.+)/i) ? ("|#{$1}>".prepend(/\[#{$2}\]: (.+)/i.match(markdown) { |n| "<#{$1}" })) : "[#{$1}][#{$2}]" } # Reference-style links
      .gsub(/\[(.+?)\]/) { |m| markdown.match?(/\[#{$1}\]: (.+)/i) ? ("|#{$1}>".prepend(/\[#{$1}\]: (.+)/i.match(markdown) { |n| "<#{$1}" })) : "[#{$1}]" } # Reference-style - Text only links
      .gsub(/\^<.+?|.+?>: .+/, '') # Remove link references
      .strip
  end
end
