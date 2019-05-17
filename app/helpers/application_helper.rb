module ApplicationHelper
  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'

  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
    include Redcarpet::Render::SmartyPants

    def link(link, title, content)
      if link =~ /^(http)|^\//i
        "<a href=\"#{link}\" title=\"#{title}\">#{content}</a>"
      else
        return nil unless note = Note.find_by(id: link.match(/^note:(\d+)/i)[1])
        if content.blank?
          "<a class=\"inline-link-card card-motif-#{note.category.color}\" href=\"#{Rails.application.routes.url_helpers.workspace_category_note_path(note.category.workspace, note.category, note)}\" >#{note.name}</a>"
        else
          "<a class=\"inline-link-card card-motif-#{note.category.color}\" href=\"#{Rails.application.routes.url_helpers.workspace_category_note_path(note.category.workspace, note.category, note)}\" >#{content}</a>"
        end
      end
    end
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
