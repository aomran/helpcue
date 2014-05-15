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

  def editable(object, attribute, data)
    if policy(object).update?
      content_tag :span, object.send(attribute), class: "editable #{attribute}", data: data.merge(name: attribute, resource: object.class.name.downcase, inputclass: 'form-input')
    else
      content_tag :span, object.send((attribute.to_s + '_or_placeholder').to_sym), class: "#{attribute}"
    end
  end
end
