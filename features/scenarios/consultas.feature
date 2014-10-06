# -*- encoding : utf-8 -*-
# language: pt

Funcionalidade: Gerenciamento de consultas
  Para que notificações e relatórios possam ser geradas com a menor intervenção possível da equipe de desenvolvimento
  Como um administrador do sistema
  Eu devo poder gerenciar consultas pré cadastradas no sistema.
  Estas consultas devem servir de base para a criação de notificações e relatórios.


  Contexto:
    Dado que eu esteja logado como um administrador

  @javascript
  Cenário: Cadastro de consultas simples
    Dado que eu esteja na página de cadastro de consultas
    E crie eu uma consulta simples corretamente
    Então a consulta deve aparecer na listagem de consultas

  @javascript
  Cenário: Cadastro de consulta parametrizada
    Dado que eu esteja na página de cadastro de consultas
    E crie eu uma consulta com data_consulta corretamente, mas sem valor padrão
    Então a consulta deve aparecer na listagem de consultas


  @javascript
  Cenário: Cadastro de consulta parametrizada customizada
    Dado que eu esteja na página de cadastro de consultas
    E crie eu uma consulta com data_consulta e parametro_1 corretamente, mas sem valor padrão
    Então a consulta deve aparecer na listagem de consultas


  @javascript
  Cenário: Cadastro de consulta parametrizada customizada
    Dado que eu esteja na página de cadastro de consultas
    E crie eu uma consulta com data_consulta e parametro_1 corretamente, mas sem valor padrão
    Então a consulta deve aparecer na listagem de consultas