RestInPlaceEditor.forms =
  "textarea" :
    activateForm : ->
      value = $.trim(@elementHTML())
      @$element.html("""<form action="javascript:void(0)" style="display:inline;">
        <textarea class="form-input rest-in-place-#{@attributeName}" placeholder="#{@placeholder}"></textarea>
        <input class='btn btn-small save' type='submit' value='Save'>
        </form>""")
      @$element.find('textarea').val(value)
      @$element.find('textarea')[0].select()
      @$element.find("input.save").click => @update()
      @$element.find("textarea").keydown (e) =>
        if e.keyCode == 27
          @abort()
        else if(e.keyCode == 13 && (e.metaKey || e.ctrlKey))
          @update()

    getValue : ->
      @$element.find("textarea").val()