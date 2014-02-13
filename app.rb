require "sinatra"
require_relative "lib/html_processor"

post "/" do
  lang_map = {
    'CoffeeScript' => 'coffee',
    'Javascript'   => 'js'
  }
  lang      = lang_map[params[:syntax]] ? lang_map[params[:syntax]] : params[:syntax]
  text      = params[:text]
  syntax    = Textpow.syntax(lang)
  processor = HTMLProcessor.new
  res       = syntax.parse(text, processor)
  body      = res.text.join("")
end

get "/" do
  "This is TmThemeEditor Parser"
end
