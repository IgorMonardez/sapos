module ActiveScaffoldHelpers

  def as_find_record_on_listing(klass, *values)
    record_class = klass.to_s.underscore.pluralize
    within("#as_#{record_class}-tbody") do
      contains = values.collect { |v|"[contains(., '#{v}')]" }.join('')
      page.find(:xpath, "//tr#{contains}")
    end
  end

end
World(ActiveScaffoldHelpers)