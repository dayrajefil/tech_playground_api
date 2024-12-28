# spec/models/organizacao_spec.rb
require 'rails_helper'

RSpec.describe Organizacao, type: :model do
  it { is_expected.to belong_to :pessoa }

  it { is_expected.to validate_presence_of :n0_empresa }
  it { is_expected.to validate_presence_of :n1_diretoria }
  it { is_expected.to validate_presence_of :n2_gerencia }
  it { is_expected.to validate_presence_of :n3_coordenacao }
  it { is_expected.to validate_presence_of :n4_area }

  context 'when all the data is present' do
    it 'must be valid' do
      pessoa = create(:pessoa, :valid)
      organizacao = build(:organizacao, :valid, pessoa: pessoa)

      expect(organizacao).to be_valid
    end
  end

  context 'when data is missing' do
    it 'should not be valid' do
      pessoa = create(:pessoa, :valid)
      organizacao = build(:organizacao, :invalid, pessoa: pessoa)

      expect(organizacao).not_to be_valid
      expect(organizacao.errors.full_messages).to eq [
          "N0 empresa não pode ficar em branco",
          "N1 diretoria não pode ficar em branco",
          "N2 gerencia não pode ficar em branco",
          "N3 coordenacao não pode ficar em branco",
          "N4 area não pode ficar em branco"
        ]
    end
  end
end
