module CodeMirrorHelpers

  def fill_in_code_mirror(locator, options={})
    raise "Must pass a hash containing 'with'" if not options.is_a?(Hash) or not options.has_key?(:with)
    with = options.delete(:with)
    options.delete(:fill_options)
    text_field = find(:fillable_field, locator, options.merge(:visible => false))

    script = "var current_query = \"#{with}\"; $('##{text_field['id']}').parent().find('.CodeMirror')[0].CodeMirror.setValue(current_query)"
    page.execute_script(script)
  end
end
World(CodeMirrorHelpers)