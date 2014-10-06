# -*- encoding : utf-8 -*-
# language: pt

Funcionalidade: Login
  Para poder acessar o SAPOS
  Como um usuário já existente no sistema
  Eu devo poder fazer login


  Contexto:
    Dado que eu não esteja logado
    E que existe um usuário de cada papel cadastrado no sistema

  Esquema do Cenário: Login com sucesso
    Dado que eu esteja na página inicial
    E que eu preencha o formulário de login com dados válidos de um <papel>
    Quando eu envio o formulário de login
    Então eu devo estar na página <página>
    E eu devo estar logado no sistema
  Exemplos:
    | papel         | página                    |
    | administrador | de listagem de matrículas |
    | coordenador   | de listagem de matrículas |
    | professor     | de listagem de matrículas |
    | secretária    | de listagem de matrículas |
    | aluno         | inicial                   |
    | desconhecido  | inicial                   |

