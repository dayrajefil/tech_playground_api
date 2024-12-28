# frozen_string_literal: true

# spec/models/organizacao_spec.rb
require 'rails_helper'

RSpec.describe Organizacao, type: :model do
  it { is_expected.to belong_to :pessoa }

  it { is_expected.to validate_presence_of :n0_empresa }
  it { is_expected.to validate_presence_of :n1_diretoria }
  it { is_expected.to validate_presence_of :n2_gerencia }
  it { is_expected.to validate_presence_of :n3_coordenacao }
  it { is_expected.to validate_presence_of :n4_area }
end
