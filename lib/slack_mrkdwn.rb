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
      .gsub(/\[(.+?)\]\((.+?)(?: .*?)?\)/, '<\2|\1>') # Classic link TODO: Do not match repository references
      .gsub(/\[(.+?)\]\[(.+?)\]/) { |m| markdown.match?(/\[#{$2}\]: (.+)/i) ? ("|#{$1}>".prepend(/\[#{$2}\]: (.+)/i.match(markdown) { |n| "<#{$1}" })) : "[#{$1}][#{$2}]" } # Reference style links
      .gsub(/\[(.+?)\]/) { |m| markdown.match?(/\[#{$1}\]: (.+)/i) ? ("|#{$1}>".prepend(/\[#{$1}\]: (.+)/i.match(markdown) { |n| "<#{$1}" })) : "[#{$1}]" } # Reference style - Text only links
      .gsub(/\^<.+?|.+?>: .+/, '') # Remove link references
      .strip
      # Ordered lists (TODO: Need to properly adjust numbers since they don't matter in markdown, also handle sublists)
  
      # Requires ruby >= 2.4.6 (because of `match?`)
  
      # Things that don't need to be modified:
      # - single line `codeblocks`
      # - Blockquotes
      # - Links on their own get turned into links by Slack (same as Markdown) (Does not check for leading \t ?)
    end
end