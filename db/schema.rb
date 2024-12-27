# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_12_27_003253) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "organizacoes", force: :cascade do |t|
    t.bigint "pessoa_id", null: false
    t.string "n0_empresa", null: false
    t.string "n1_diretoria", null: false
    t.string "n2_gerencia", null: false
    t.string "n3_coordenacao", null: false
    t.string "n4_area", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pessoa_id"], name: "index_organizacoes_on_pessoa_id"
  end

  create_table "pessoas", force: :cascade do |t|
    t.string "nome", null: false
    t.string "email", null: false
    t.string "email_corporativo", null: false
    t.integer "area", null: false
    t.integer "cargo", null: false
    t.integer "funcao", null: false
    t.integer "localidade", null: false
    t.integer "tempo_de_empresa", null: false
    t.integer "genero", null: false
    t.integer "geracao", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email", "email_corporativo"], name: "index_pessoas_on_email_and_email_corporativo", unique: true
  end

  create_table "retornos", force: :cascade do |t|
    t.bigint "pessoa_id", null: false
    t.date "data_da_resposta", null: false
    t.integer "interesse_no_cargo", null: false
    t.string "comentario_interesse_no_cargo", null: false
    t.integer "contribuicao", null: false
    t.string "comentario_contribuicao", null: false
    t.integer "aprendizado_e_desenvolvimento", null: false
    t.string "comentarios_aprendizado_e_desenvolvimento", null: false
    t.integer "feedback", null: false
    t.string "comentario_feedback", null: false
    t.integer "interacao_com_gestor", null: false
    t.string "comentario_interacao_com_gestor", null: false
    t.integer "clareza_sobre_possibilidades_de_carreira", null: false
    t.string "comentario_clareza_sobre_possibilidades_de_carreira", null: false
    t.integer "expectativa_de_permanencia", null: false
    t.string "comentario_expectativa_de_permanencia", null: false
    t.integer "enps", null: false
    t.string "comentario_enps", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pessoa_id"], name: "index_retornos_on_pessoa_id"
  end

  add_foreign_key "organizacoes", "pessoas"
  add_foreign_key "retornos", "pessoas"
end
