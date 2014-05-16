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
      content_tag :span, object.send((attribute.to_s + '_or_placeholder').to_sym).html_safe, class: "#{attribute}"
    end
  end

  def request_time(request)
    content_tag :span, request.created_at.strftime("%l:%M%P, %e %b %y"), class: "timeago small", title: request.created_at.getutc.iso8601
  end

  def request_owner_name(request)
    if request.owner == current_user
      "Me"
    else
      request.owner.full_name
    end
  end

  def request_metoo_count(request)
    content_tag :span, "+#{request.users.count}", class: "me-too-count req-num #{'dont-show' if request.users.empty?}", title: "More students have this question"
  end

  def request_star_icon(request)
    if request.answer?
      content_tag :span, '', class: "request-icon has-answer", title: "Click 'More' to see answer"
    else
      content_tag :span, '', class: "request-icon no-answer", title: "No answer entered"
    end
  end

  def metoo_button(request)
    metoo_class = request.users.include?(current_user) ? '-current' : ''
    link_to me_too_classroom_request_path(id: request.id, classroom_id: @classroom.id), method: :patch, remote: true, class: 'request-action request-metoo small' do
      content_tag(:span, '', class: "action-icon metoo#{metoo_class}") + content_tag(:span, 'Me too', class: "action-label#{metoo_class}")
    end
  end
end
