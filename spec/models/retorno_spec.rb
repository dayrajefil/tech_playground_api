# spec/models/retorno_spec.rb
require 'rails_helper'

RSpec.describe Retorno, type: :model do
  it { is_expected.to belong_to(:pessoa) }

  it { is_expected.to accept_nested_attributes_for(:pessoa).allow_destroy(true) }

  it { is_expected.to validate_presence_of(:data_da_resposta) }
  it { is_expected.to validate_presence_of(:interesse_no_cargo) }
  it { is_expected.to validate_presence_of(:comentario_interesse_no_cargo) }
  it { is_expected.to validate_presence_of(:contribuicao) }
  it { is_expected.to validate_presence_of(:comentario_contribuicao) }
  it { is_expected.to validate_presence_of(:aprendizado_e_desenvolvimento) }
  it { is_expected.to validate_presence_of(:comentarios_aprendizado_e_desenvolvimento) }
  it { is_expected.to validate_presence_of(:feedback) }
  it { is_expected.to validate_presence_of(:comentario_feedback) }
  it { is_expected.to validate_presence_of(:interacao_com_gestor) }
  it { is_expected.to validate_presence_of(:comentario_interacao_com_gestor) }
  it { is_expected.to validate_presence_of(:clareza_sobre_possibilidades_de_carreira) }
  it { is_expected.to validate_presence_of(:comentario_clareza_sobre_possibilidades_de_carreira) }
  it { is_expected.to validate_presence_of(:expectativa_de_permanencia) }
  it { is_expected.to validate_presence_of(:comentario_expectativa_de_permanencia) }
  it { is_expected.to validate_presence_of(:enps) }
  it { is_expected.to validate_presence_of(:comentario_enps) }

  it { is_expected.to validate_inclusion_of(:interesse_no_cargo).in_range(1..10).with_message("deve estar entre 1 e 10") }
  it { is_expected.to validate_inclusion_of(:contribuicao).in_range(1..10).with_message("deve estar entre 1 e 10") }
  it { is_expected.to validate_inclusion_of(:aprendizado_e_desenvolvimento).in_range(1..10).with_message("deve estar entre 1 e 10") }
  it { is_expected.to validate_inclusion_of(:feedback).in_range(1..10).with_message("deve estar entre 1 e 10") }
  it { is_expected.to validate_inclusion_of(:interacao_com_gestor).in_range(1..10).with_message("deve estar entre 1 e 10") }
  it { is_expected.to validate_inclusion_of(:clareza_sobre_possibilidades_de_carreira).in_range(1..10).with_message("deve estar entre 1 e 10") }
  it { is_expected.to validate_inclusion_of(:expectativa_de_permanencia).in_range(1..10).with_message("deve estar entre 1 e 10") }
  it { is_expected.to validate_inclusion_of(:enps).in_range(1..10).with_message("deve estar entre 1 e 10") }
end
