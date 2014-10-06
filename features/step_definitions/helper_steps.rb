# -*- encoding : utf-8 -*-

Então(/^(?:eu )devo estar na (.+)$/) do |page_name|
  expect(current_path).to eq(path_to(page_name))
end

Dado(/^que eu esteja na (.+)$/) do | page_name|
  path_to(page_name)
end

Quando(/^eu clico em "([^"]*)"$/) do |link|
  click_link link
end


Dado /^(?:que )?eu não est(?:ou|eja) logado$/ do
  visit '/users/sign_out'
end

When(/^eu debugo$/) do
  debugger
  1
end

When(/^eu envio o formulário$/) do
  click_button 'Salvar'
end