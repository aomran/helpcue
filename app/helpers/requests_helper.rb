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
    if policy(request).me_too?
      metoo_class = request.users.include?(current_user) ? '-current' : ''
      link_to me_too_classroom_request_path(id: request.id, classroom_id: @classroom.id), method: :patch, remote: true, class: 'request-action request-metoo small' do
        content_tag(:span, '', class: "action-icon metoo#{metoo_class}") + content_tag(:span, 'Me too', class: "action-label#{metoo_class}")
      end
    end
  end

  def metoo_people(request)
    content_tag :p, "Also asked by: #{request.users.full_names}", class: "me-too-people dont-show"
  end

  def toggle_help_button(request)
    unless request.done?
      status_class = request.being_helped? ?  '-current' : ''
      label_and_text = content_tag(:span, '', class: "action-icon helped#{ status_class}") + content_tag(:span, "Being Helped#{'?' unless request.being_helped?}", class: "action-label#{status_class}")

      if policy(request).toggle_help?
        link_to toggle_help_classroom_request_path(id: request.id, classroom_id: @classroom.id), method: :patch, remote: true, class: 'request-action request-toggle small' do
          label_and_text
        end

      else
        content_tag :span, class: 'request-action-disabled small' do
          label_and_text
        end
      end
    end
  end

  def done_button(request)
    if request.done?
      content_tag :span, class: 'request-action-disabled small' do
        content_tag(:span, '', class: "action-icon done-current") + content_tag(:span, 'Done', class: "action-label-current")
      end
    elsif policy(request).remove?
      link_to remove_classroom_request_path(id: request.id, classroom_id: @classroom.id), method: :patch, remote: true, class: 'request-action request-remove small' do
        content_tag(:span, '', class: "action-icon done") + content_tag(:span, 'Done?', class: "action-label")
      end
    end
  end

  def more_button(request)
    link_to "#request-expand-#{request.id}", class: "open-modal request-action small", title: "More", rel: "modal:open" do
      content_tag(:span, '', class: "action-icon more") + content_tag(:span, 'More', class: "action-label")
    end
  end

  def delete_button(request)
    if policy(request).destroy?
      link_to [@classroom, request], method: :delete, remote: true, class: "request-action small request-delete", title: 'Delete my question', data: {confirm: 'Are you sure?'}  do
        content_tag(:span, '', class: "action-icon trash") + content_tag(:span, 'Delete', class: "action-label")
      end
    end
  end
end
