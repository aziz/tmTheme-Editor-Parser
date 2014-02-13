require_relative "html_processor"

text = File.read("../samples/java.txt")
syntax = Textpow.syntax("java")
processor = HTMLProcessor.new("java")
res = syntax.parse(text, processor)
p res.text.join("")
