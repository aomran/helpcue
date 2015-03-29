module ApplicationHelper

  def link_to_selected(*arg, &block)
    if current_page?(arg[0]) || (arg[0] == '' && params[:controller] == 'registrations')
      options = arg.extract_options!
      options[:class] += ' selected'
      arg << options
    end

    link_to(*arg, &block)
  end

  def current_page_header
    if params[:controller] == 'registrations'
      'Account'
    elsif params[:controller] == 'requests'
      'Queue'
    elsif params[:controller] == 'hashtags'
      'Tags'
    else
      params[:controller].capitalize
    end
  end

  def full_title(page_title)
    base_title = "HelpCue"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

end
