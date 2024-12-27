# frozen_string_literal: true

require 'csv'

# Serviço responsável pela importação de dados a partir de arquivos CSV.
# Este serviço processa um arquivo CSV contendo informações de pessoas, suas organizações
# e feedbacks, realizando a criação de registros no banco de dados.
#
# O método `import` lê o arquivo, valida os dados e cria os registros necessários
# nas tabelas de `Pessoa`, `Organizacao` e `Retorno`. Caso ocorram erros de validação,
# a transação é revertida e os erros são coletados para serem retornados ao usuário.
#
class ImportCsvService
  attr_reader :file, :errors

  def initialize(file)
    @file = file
    @errors = []
  end

  def import
    ActiveRecord::Base.transaction do
      CSV.foreach(file.path, headers: true, col_sep: ';') do |row|
        pessoa = create_pessoa(row)
        next add_errors_to_collection(pessoa, nil, nil) unless pessoa.valid?

        organizacao = create_organizacao(pessoa, row)
        retorno = create_retorno(pessoa, row)

        add_errors_to_collection(pessoa, organizacao, retorno)
      end
    end
  end

  def create_pessoa(row)
    pessoa = Pessoa.new(pessoa_attributes(row))
    pessoa.save
    pessoa
  end

  def create_retorno(pessoa, row)
    retorno = Retorno.new(retorno_attributes(pessoa, row))
    retorno.save
    retorno
  end

  def create_organizacao(pessoa, row)
    organizacao = Organizacao.new(organizacao_attributes(pessoa, row))
    organizacao.save
    organizacao
  end

  private

  def add_errors_to_collection(pessoa, organizacao, retorno)
    [pessoa, organizacao, retorno].each do |objeto|
      next unless objeto&.errors&.any?

      errors_hash = {}

      objeto.errors.messages.each do |attribute, messages|
        errors_hash[attribute] = {
          value: objeto.send(attribute), messages: messages
        }
      end

      @errors << { objeto.class.name.downcase.to_sym => errors_hash }
    end
  end

  def pessoa_attributes(row) # rubocop:disable Metrics/MethodLength
    {
      nome: row['nome'],
      email: row['email'],
      email_corporativo: row['email_corporativo'],
      area: Area.value_from_translation(row['area']),
      cargo: Cargo.value_from_translation(row['cargo']),
      funcao: Funcao.value_from_translation(row['funcao']),
      localidade: Localidade.value_from_translation(row['localidade']),
      tempo_de_empresa: TempoDeEmpresa.value_from_translation(row['tempo_de_empresa']),
      genero: Genero.value_from_translation(row['genero']),
      geracao: Geracao.value_from_translation(row['geracao'])
    }
  end

  def retorno_attributes(pessoa, row) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength:
    {
      pessoa_id: pessoa.id,
      data_da_resposta: parse_date(row['Data da Resposta']),
      interesse_no_cargo: row['Interesse no Cargo'].to_i,
      comentario_interesse_no_cargo: row['Comentários - Interesse no Cargo'],
      contribuicao: row['Contribuição'].to_i,
      comentario_contribuicao: row['Comentários - Contribuição'],
      aprendizado_e_desenvolvimento: row['Aprendizado e Desenvolvimento'].to_i,
      comentarios_aprendizado_e_desenvolvimento: row['Comentários - Aprendizado e Desenvolvimento'],
      feedback: row['Feedback'].to_i,
      comentario_feedback: row['Comentários - Feedback'],
      interacao_com_gestor: row['Interação com Gestor'].to_i,
      comentario_interacao_com_gestor: row['Comentários - Interação com Gestor'],
      clareza_sobre_possibilidades_de_carreira: row['Clareza sobre Possibilidades de Carreira'].to_i,
      comentario_clareza_sobre_possibilidades_de_carreira:
        row['Comentários - Clareza sobre Possibilidades de Carreira'],
      expectativa_de_permanencia: row['Expectativa de Permanência'].to_i,
      comentario_expectativa_de_permanencia: row['Comentários - Expectativa de Permanência'],
      enps: row['eNPS'].to_i,
      comentario_enps: row['[Aberta] eNPS']
    }
  end

  def organizacao_attributes(pessoa, row)
    {
      pessoa_id: pessoa.id,
      n0_empresa: row['n0_empresa'],
      n1_diretoria: row['n1_diretoria'],
      n2_gerencia: row['n2_gerencia'],
      n3_coordenacao: row['n3_coordenacao'],
      n4_area: row['n4_area']
    }
  end

  def parse_date(date_string)
    Date.strptime(date_string, '%d/%m/%Y')
  rescue StandardError
    nil
  end
end
