class ClassroomDecorator < Draper::Decorator
  delegate_all

  def settings_icon
    if h.policy(object).update?
      h.content_tag :span, class: "pr" do
        h.link_to '', "#edit-classroom#{id}", rel: "modal:open", class: "open-modal classroom-settings"
      end
    end
  end

  def description_or_placeholder
    description.blank? ? 'No description was added to this classroom.' : description
  end

  def user_count
    users = classroom.users.count
    h.content_tag :div do
      h.content_tag(:span, '', class: "class-icons student-icon") +
      h.content_tag(:span, users, class: 'number') +
      h.content_tag(:span, " #{'person'.pluralize(users)} in this classroom")
    end
  end

end