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
end
