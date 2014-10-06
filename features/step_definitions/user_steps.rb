# -*- encoding : utf-8 -*-

Dado(/^que existe um usuário de cada papel cadastrado no sistema$/) do
  new_user_for('administrador')
  new_user_for('coordenador')
  new_user_for('professor')
  new_user_for('secretária')
  new_user_for('aluno')
  new_user_for('desconhecido')
end
