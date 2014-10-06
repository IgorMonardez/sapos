# -*- encoding : utf-8 -*-
# language: pt

Funcionalidade: Gerenciamento de Alunos
  Como um administrador do sistema
  Eu devo poder gerenciar os alunos cadastrados no sistema


  Contexto:
    Dado que eu esteja logado como um administrador

  Cenario: Cadastro de alunos
    Dado que eu esteja na página de cadastro de alunos
    E que eu preencha o formulário de cadastro de alunos com as informações básicas
    Quando eu envio o formulário
    Então o aluno deve ter sido criado com sucesso
