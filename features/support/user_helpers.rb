# -*- encoding : utf-8 -*-

module CucumberUserHelpers
  def create_user(name, email, role)
    user = FactoryGirl.create(:user, name: "#{name} Teste", email: email, role: Role.find(role))
    user.confirm!
    user
  end

  def current_user_for(papel)
    mapeamento_papeis = {
        'administrador' => @administrador,
        'coordenador' => @coordenador,
        'professor' => @professor,
        'secretária' => @secretaria,
        'aluno' => @aluno,
        'desconhecido' => @desconhecido,
    }
    raise "Nome de papel inválido para: #{papel}" unless mapeamento_papeis.has_key?(papel)
    mapeamento_papeis[papel]
  end

  def new_user_for(papel)
    case papel
      when 'administrador'
        @administrador = create_user('Administrador', 'administrador@email.com', Role::ROLE_ADMINISTRADOR)
      when 'coordenador'
        @coordenador = create_user('Coordenador', 'coordenador@email.com', Role::ROLE_COORDENACAO)
      when 'professor'
        @professor = create_user('Professor', 'professor@email.com', Role::ROLE_PROFESSOR)
      when 'secretária'
        @secretaria = create_user('Secretária', 'secretaria@email.com', Role::ROLE_SECRETARIA)
      when 'aluno'
        @aluno = create_user('Aluno', 'aluno@email.com', Role::ROLE_ALUNO)
      when 'desconhecido'
        @desconhecido = create_user('Desconhecido', 'desconhecido@email.com', Role::ROLE_DESCONHECIDO)
      else
        raise "Papel desconhecido para criação de usuário: #{papel}"
    end

  end
end

World(CucumberUserHelpers)