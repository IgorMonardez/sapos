# -*- encoding : utf-8 -*-

When(/^que eu preencha o formulário de cadastro de alunos com as informações básicas$/) do
  fill_in 'Nome', with: 'Aluno Teste'
  fill_in 'CPF', with: '123.123.123-12'
end

When(/^o aluno deve ter sido criado com sucesso$/) do
  as_find_record_on_listing Student, 'Aluno Teste'
end