module RequestsHelper

  def search_count(numb)
    "<p>#{numb} #{'result'.pluralize(numb)}</p>".html_safe
  end

  def question_count(numb)
    "<p>#{numb} #{'question'.pluralize(numb)}</p>".html_safe
  end

  def display_duration(seconds)
    ChronicDuration.output(seconds, :keep_zero => true)
  end

  def in_place_edit(permission, modal_object, attribute, data)
    if permission
      content_tag :span, modal_object.send(attribute), class: 'rest-in-place', data: data
    else
      content_tag :span, modal_object.send(attribute)
    end
  end
end
