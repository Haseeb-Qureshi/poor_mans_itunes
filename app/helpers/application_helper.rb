module ApplicationHelper
  include ERB::Util

  def list_options(my_object)
    my_object.class.all.inject([]) do |options, obj|
      selected = obj.id == my_object.id ? " selected" : ""
      options << "<option value=\"#{obj.id}\"#{selected}>#{obj.name.html_safe}</option>"
    end.join("\n").html_safe
  end

  def ugly_lyrics(lyrics)
    formatted_lyrics = lyrics.lines.map do |line|
      "&#9835; " + line.html_safe
    end.join("\n")
    "<pre>#{formatted_lyrics}</pre>".html_safe
  end
end
