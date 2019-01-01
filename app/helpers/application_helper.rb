module ApplicationHelper
  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'

  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
    include Redcarpet::Render::SmartyPants
  end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      no_images:       true,
      space_after_headers: true,
      safe_links_only: true,
    }

    extensions = {
      autolink:           true,
      strikethrough:      true,
      underline:          true,
      highlight:          true,
      no_intra_emphasis:  true,
      superscript:        true,
      tables:             true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
    }

    renderer = HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def flash_class(key)
    case key
      when 'notice'  then 'alert alert-info'
      when 'success' then 'alert alert-success'
      when 'error'   then 'alert alert-error'
      when 'alert'   then 'alert alert-error'
    end
  end

end
