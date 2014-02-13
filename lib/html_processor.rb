require_relative 'textpow'
require 'cgi'

class HTMLProcessor

  attr_reader :text

  def start_parsing(scope_name)
    @text= []
  end

  def end_parsing(scope_name)
    if @line
      @compiled += CGI::escapeHTML(@line[@position..-1])
    end
    @text << @compiled
    @text.each_with_index do |line, index|
      @text[index] = "<span class='l l-#{index+1} #{scope_name.gsub('.',' ')}'>#{line}</span>"
    end
  end

  def new_line(line_content)
    if @line
      @compiled += CGI::escapeHTML(@line[@position..-1])
    end
    @text << @compiled if @compiled
    @line = line_content.clone
    @compiled = ""
    @position = 0
  end

  def open_tag(tag_name, position)
    @compiled += CGI::escapeHTML(@line[@position...position]) if position > @position
    @compiled += "<s class='#{tag_name.gsub("."," ")}' data-entity-scope='#{tag_name}'>"
    @position = position
  end

  def close_tag(tag_name, position)
    @compiled += CGI::escapeHTML(@line[@position...position]) if position > @position
    @compiled += "</s>"
    @position = position
  end

end
