class RequestDecorator < Draper::Decorator
  delegate_all

  def gravatar_image
    h.image_tag "#{owner.avatar}?s=120", class: 'gravatar-image'
  end

  def time
    h.content_tag :span, created_at.strftime("%l:%M%P, %e %b %y"), class: "timeago small", title: created_at.getutc.iso8601, data: { timestamp: created_at }
  end

  def owner_name
    h.current_user.owner?(model) ? 'Me' : owner.full_name
  end

  def metoo_count
    h.content_tag :span, "+#{users.count}", class: "me-too-count req-num #{'dont-show' if users.empty?}", title: "More students have this question", data: { count: users.count }
  end

  def star_icon
    title = answer? ? "Click 'More' to see note" : "No note added"
    h.content_tag :span, '', class: "request-icon answer-#{answer?}", title: title
  end

  def question_or_placeholder
    question.blank? ? "<p class='lightgrey-text'> Blank question </p>".html_safe : question
  end

  def answer_or_placeholder
    answer.blank? ? "<p class='lightgrey-text'> No note yet </p>".html_safe : answer
  end

  def question_with_hashtags
    question_or_placeholder
  end

  def metoo_button
    if h.policy(object).me_too?
      metoo_class = users.include?(h.current_user) ? '-current' : ''
      h.link_to h.me_too_classroom_request_path(id: id, classroom_id: classroom.id), method: :patch, remote: true, class: 'request-action request-metoo small' do
        h.content_tag(:span, '', class: "action-icon metoo#{metoo_class}") + h.content_tag(:span, 'Me too', class: "action-label#{metoo_class}")
      end
    end
  end

  def metoo_people
    h.content_tag :p, "Also asked by: #{users.full_names}", class: "me-too-people dont-show"
  end

  def toggle_help_button
    if h.policy(object).toggle_help?
      state_update_link 'toggle_state', 'request-toggle' do
        toggle_button_label
      end
    elsif !done?
      h.content_tag :span, class: 'request-action-disabled small' do
        toggle_button_label
      end
    end
  end

  def done_button
    if done?
      h.content_tag :span, class: 'request-action-disabled small' do
        done_button_label(true)
      end
    elsif h.policy(object).remove?
      state_update_link 'remove', 'request-remove' do
        done_button_label(false)
      end
    end
  end

  def more_button
    h.link_to "#request-expand-#{id}", class: "open-modal request-action small", title: "More", rel: "modal:open" do
      h.content_tag(:span, '', class: "action-icon more") + h.content_tag(:span, 'More', class: "action-label")
    end
  end

  def delete_button
    if h.policy(object).destroy?
      h.link_to [classroom, request], method: :delete, remote: true, class: "request-action small request-delete", title: 'Delete my question', data: {confirm: 'Are you sure?'}  do
        h.content_tag(:span, '', class: "action-icon trash") + h.content_tag(:span, 'Delete', class: "action-label")
      end
    end
  end

  protected
  def toggle_button_label
    state_class = being_helped? ?  '-current' : ''
    h.content_tag(:span, '', class: "action-icon helped#{state_class}") + h.content_tag(:span, "Being Helped#{'?' unless being_helped?}", class: "action-label#{state_class}")
  end

  def done_button_label(current)
    css_class = current ? '-current': ''
    inflection = current ? '' : '?'
    h.content_tag(:span, '', class: "action-icon done#{css_class}") + h.content_tag(:span, "Done#{inflection}", class: "action-label#{css_class}")
  end

  def state_update_link(action, css_class, &block)
    h.link_to h.classroom_request_path(id: id, classroom_id: classroom.id, state_action: action), {method: :patch, remote: true, class: "request-action #{css_class} small"}, &block
  end

end
