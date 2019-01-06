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
      no_images:       false,
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

  # From https://github.com/rwz/nestive/blob/master/lib/nestive/layout_helper.rb
  def extends(layout, &block)
    layout = layout.to_s
    layout = "layouts/#{layout}" unless layout.include?('/')
    @view_flow.get(:layout).replace capture(&block)
    render file: layout
  end

  def flash_class(key)
    case key
      when 'notice'  then 'alert alert-info'
      when 'success' then 'alert alert-success'
      when 'error'   then 'alert alert-danger'
      when 'alert'   then 'alert alert-danger'
    end
  end

end
