# frozen_string_literal: true

# Migração responsável pela criação da tabela 'retornos', que armazena os dados de feedback
# dos funcionários, incluindo informações sobre interesse no cargo, contribuição,
# aprendizado, feedback, interação com o gestor, entre outros.
#
class CreateRetornos < ActiveRecord::Migration[7.1]
  def change
    create_table :retornos do |t|
      t.references :pessoa, null: false, foreign_key: true
      t.date :data_da_resposta, null: false
      t.integer :interesse_no_cargo, null: false
      t.string :comentario_interesse_no_cargo, null: false
      t.integer :contribuicao, null: false
      t.string :comentario_contribuicao, null: false
      t.integer :aprendizado_e_desenvolvimento, null: false
      t.string :comentarios_aprendizado_e_desenvolvimento, null: false
      t.integer :feedback, null: false
      t.string :comentario_feedback, null: false
      t.integer :interacao_com_gestor, null: false
      t.string :comentario_interacao_com_gestor, null: false
      t.integer :clareza_sobre_possibilidades_de_carreira, null: false
      t.string :comentario_clareza_sobre_possibilidades_de_carreira, null: false
      t.integer :expectativa_de_permanencia, null: false
      t.string :comentario_expectativa_de_permanencia, null: false
      t.integer :enps, null: false
      t.string :comentario_enps, null: false

      t.timestamps
    end
  end
end
