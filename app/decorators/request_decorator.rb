class RequestDecorator < Draper::Decorator
  delegate_all

  def gravatar_image
    h.image_tag "#{owner.avatar}?s=120", class: 'gravatar-image'
  end

  def time
    h.content_tag :span, created_at.strftime("%l:%M%P, %e %b %y"), class: "timeago small", title: created_at.getutc.iso8601
  end

  def owner_name
    owner.id == h.current_user.id ? 'Me' : owner.full_name
  end

  def metoo_count
    h.content_tag :span, "+#{users.count}", class: "me-too-count req-num #{'dont-show' if users.empty?}", title: "More students have this question"
  end

  def star_icon
    title = answer? ? "Click 'More' to see answer" : "No answer entered"
    h.content_tag :span, '', class: "request-icon answer-#{answer?}", title: title
  end

  def question_or_placeholder
    question.blank? ? "<p class='lightgrey-text'> Blank question </p>" : question
  end

  def answer_or_placeholder
    answer.blank? ? "<p class='lightgrey-text'> No answer yet </p>" : answer
  end

  def question_with_hashtags
    h.linkify_hashtags(question_or_placeholder)
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
    unless done?
      status_class = being_helped? ?  '-current' : ''
      label_and_text = h.content_tag(:span, '', class: "action-icon helped#{ status_class}") + h.content_tag(:span, "Being Helped#{'?' unless being_helped?}", class: "action-label#{status_class}")

      if h.policy(object).toggle_help?
        h.link_to h.toggle_help_classroom_request_path(id: id, classroom_id: classroom.id), method: :patch, remote: true, class: 'request-action request-toggle small' do
          label_and_text
        end

      else
        h.content_tag :span, class: 'request-action-disabled small' do
          label_and_text
        end
      end
    end
  end

  def done_button
    if done?
      h.content_tag :span, class: 'request-action-disabled small' do
        h.content_tag(:span, '', class: "action-icon done-current") + h.content_tag(:span, 'Done', class: "action-label-current")
      end
    elsif h.policy(object).remove?
      h.link_to h.remove_classroom_request_path(id: id, classroom_id: classroom.id), method: :patch, remote: true, class: 'request-action request-remove small' do
        h.content_tag(:span, '', class: "action-icon done") + h.content_tag(:span, 'Done?', class: "action-label")
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

end
