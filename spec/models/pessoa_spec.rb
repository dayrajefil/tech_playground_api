# frozen_string_literal: true

# spec/models/pessoa_spec.rb
require 'rails_helper'

RSpec.describe Pessoa, type: :model do
  it { is_expected.to have_one(:organizacao).dependent(:destroy) }
  it { is_expected.to have_one(:retorno).dependent(:destroy) }

  it { is_expected.to accept_nested_attributes_for(:organizacao).allow_destroy(true) }

  it { is_expected.to validate_presence_of :nome }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :email_corporativo }
  it { is_expected.to validate_presence_of :area }
  it { is_expected.to validate_presence_of :cargo }
  it { is_expected.to validate_presence_of :funcao }
  it { is_expected.to validate_presence_of :localidade }
  it { is_expected.to validate_presence_of :tempo_de_empresa }
  it { is_expected.to validate_presence_of :genero }
  it { is_expected.to validate_presence_of :geracao }

  context 'when the email already exists' do
    it 'must not be valid with duplicate email' do
      pessoa1 = create(:pessoa, :valid, email: 'joao@example.com')
      pessoa2 = build(:pessoa, :valid, email: pessoa1.email)

      expect(pessoa2).not_to be_valid
      expect(pessoa2.errors[:email]).to include('já está em uso')
    end
  end

  context 'when the corporate email already exists' do
    it 'is not valid with duplicate corporate email' do
      pessoa1 = create(:pessoa, :valid, email_corporativo: 'joao@empresa.com')
      pessoa2 = build(:pessoa, :valid, email_corporativo: pessoa1.email_corporativo)

      expect(pessoa2).not_to be_valid
      expect(pessoa2.errors[:email_corporativo]).to include('já está em uso')
    end
  end
end
