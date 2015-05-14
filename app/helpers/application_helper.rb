module ApplicationHelper
  def list_options(my_object)
    my_object.class.all.inject([]) do |options, obj|
      selected = obj.id == my_object.id ? " selected" : ""
      options << "<option value=\"#{obj.id}\"#{selected}>#{obj.name.html_safe}</option>"
    end.join("\n").html_safe
  end
end
