# -*- encoding : utf-8 -*-
When(/^que eu preencha o formulário de login com dados válidos de um (.*)$/) do |papel|

  @user = current_user_for(papel)

  fill_in 'Email', with: @user.email
  fill_in 'Senha', with: 'password'

end

When(/^eu envio o formulário de login$/) do
  click_button 'Login'
end

When(/^eu devo estar logado no sistema$/) do
  page.should have_content 'Logout'
end

When(/^que eu esteja logado como um (.*)$/) do |papel|
  @user = current_user_for(papel)
  @user = new_user_for(papel) unless @user
  login_as(@user, :scope => :user)
end