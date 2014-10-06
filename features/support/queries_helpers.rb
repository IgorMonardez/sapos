# -*- encoding : utf-8 -*-
module QueriesHelpers

  SIMPLE_QUERY = "SELECT name FROM students WHERE students.created_at < '01/01/2020'"
  DATE_ONLY_QUERY = "SELECT name FROM students WHERE students.created_at < :data_consulta"


  def fill_in_query_param(type, name, value)
    begin
      empty_line = all(:css, "li.params-sub-form tbody tr input.name-input").find { |el| el.value.empty? }.find :xpath, '../../../..'
    rescue
      click_link 'Criar Outro'
      empty_line = all(:css, "li.params-sub-form tbody tr input.name-input").find { |el| el.value.empty? }.find :xpath, '../../../..'
    end
    within empty_line do
      select type, from: find('select')['id']
      fill_in find(:css, 'input.name-input')['id'], with: name
      fill_in find(:css, 'input.default_value-input')['id'], with: value
    end
  end
end
World(QueriesHelpers)