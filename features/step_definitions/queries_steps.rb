# -*- encoding : utf-8 -*-

When(/^crie eu uma consulta simples corretamente$/) do
  @current_query = "Consulta Simples Teste"
  fill_in 'Nome', with: @current_query
  fill_in 'Descrição', with: "Descrição da #{@current_query}"
  fill_in_code_mirror 'Consulta', with: QueriesHelpers::SIMPLE_QUERY
  click_button 'Salvar'
end

When(/^a consulta deve aparecer na listagem de consultas$/) do
  as_find_record_on_listing(Query, @current_query)
end

When(/^crie eu uma consulta com data_consulta(?: ?[e,] ([a-zA-Z0-9_, ]+))? corretamente, mas sem valor padrão$/) do |variaveis|
  @current_query = "Consulta Com Data_Consulta"
  fill_in 'Nome', with: @current_query
  fill_in 'Descrição', with: "Descrição da #{@current_query}"

  query = QueriesHelpers::DATE_ONLY_QUERY

  # debugger
  fill_in_query_param 'Date', 'data_consulta', ''
  variaveis.gsub(' e ', ', ').split(', ').each do |variavel|
    fill_in_query_param 'String', variavel, ''
    query += " AND :#{variavel} = :#{variavel}"
  end

  fill_in_code_mirror 'Consulta', with: query
  click_button 'Salvar'
end