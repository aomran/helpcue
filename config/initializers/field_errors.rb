ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag =~ /\<label/
    html_tag
  else
    errors = Array(instance.error_message).join(', ')
    %(<span class="error-message h6">&nbsp;#{errors}</span><span class='error'>#{html_tag}</span>).html_safe
  end
end