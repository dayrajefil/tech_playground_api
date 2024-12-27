# frozen_string_literal: true

# Migração responsável pela criação da tabela 'pessoas',
# que armazena informações pessoais e profissionais dos funcionários.
# A tabela inclui campos como nome, email, cargo, função, e outros dados relacionados à pessoa.
#
class CreatePessoas < ActiveRecord::Migration[7.1]
  def change
    create_table :pessoas do |t|
      t.string :nome, null: false
      t.string :email, null: false
      t.string :email_corporativo, null: false
      t.integer :area, null: false
      t.integer :cargo, null: false
      t.integer :funcao, null: false
      t.integer :localidade, null: false
      t.integer :tempo_de_empresa, null: false
      t.integer :genero, null: false
      t.integer :geracao, null: false

      t.timestamps
    end

    add_index :pessoas, %i[email email_corporativo], unique: true
  end
end
