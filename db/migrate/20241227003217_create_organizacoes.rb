# frozen_string_literal: true

# Migração responsável pela criação da tabela 'organizacoes', que armazena as informações
# hierárquicas das organizações, associando cada registro a uma pessoa.
# A tabela inclui colunas para a empresa e diferentes níveis de hierarquia.
#
class CreateOrganizacoes < ActiveRecord::Migration[7.1]
  def change
    create_table :organizacoes do |t|
      t.references :pessoa, null: false, foreign_key: true
      t.string :n0_empresa, null: false
      t.string :n1_diretoria, null: false
      t.string :n2_gerencia, null: false
      t.string :n3_coordenacao, null: false
      t.string :n4_area, null: false

      t.timestamps
    end
  end
end
