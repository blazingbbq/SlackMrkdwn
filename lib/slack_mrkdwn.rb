# frozen_string_literal: true
require 'redcarpet'

class SlackMrkdwn < Redcarpet::Render::Base
  # Methods where the first argument is the text content
  [
    # block-level calls
    :block_html,

    :autolink,
    :raw_html,

    :table, :table_row, :table_cell,

    :superscript, :highlight,

    # footnotes
    :footnotes, :footnote_def, :footnote_ref,

    :hrule,

    # low level rendering
    :entity, :normal_text,

    :doc_header, :doc_footer,
  ].each do |method|
    define_method method do |*args|
      args.first
    end
  end
  
  # Encode Slack restricted characters
  def preprocess(content)
    content.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;')
  end

  def postprocess(content)
    content.rstrip
  end

  # ~~strikethrough~~
  def strikethrough(content)
    "~#{content}~"
  end

  # _italic_
  def underline(content)
    "_#{content}_"
  end

  # *italic*
  def emphasis(content)
    "_#{content}_"
  end

  # **bold**
  def double_emphasis(content)
    "*#{content}*"
  end

  # ***bold and italic***
  def triple_emphasis(content)
    "*_#{content}_*"
  end

  # ``` code block ```
  def block_code(content, _language)
    "```\n#{content}```\n"
  end

  # > quote
  def block_quote(content)
    "&gt; #{content}"
  end

  # `code`
  def codespan(content)
    "`#{content}`"
  end

  # links
  def link(link, _title, content)
    "<#{link}|#{content}>"
  end

  # lists
  def list(entries, list_type)
    reset_list(list_type)
    entries
  end

  def reset_list(list_type)
    @list_item_count = 0 if list_type == :ordered
  end

  def list_prefix(list_type)
    return "-" if list_type == :unordered
    @list_item_count = 0 unless @list_item_count
    @list_item_count += 1
    "#{@list_item_count}."
  end

  def list_item(entry, list_type)
    "#{list_prefix(list_type)} #{entry}"
  end

  # ![](image)
  def image(link, _title, _alt_text)
    link
  end

  def linebreak()
    "\n"
  end

  def paragraph(text)
    "#{text}\n"
  end

  def header(text, _header_level)
    "*#{text}*\n"
  end

  class << self
    def from(markdown)
      renderer = SlackMrkdwn.new
      Redcarpet::Markdown.new(renderer, strikethrough: true, underline: true, fenced_code_blocks: true).render(markdown)
    end
  end
end