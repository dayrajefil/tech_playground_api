# frozen_string_literal: true

require 'enumerate_it'
require 'rails_helper'

RSpec.describe Geracao do
  describe '.associate_values' do
    it 'associates the correct keys' do
      expect(described_class.enumeration.keys).to eq(%i[
                                                       baby_boomer x_generation y_generation z_generation
                                                     ])
    end

    it 'associates the correct values' do
      expect(Geracao::BABY_BOOMER).to eq(0)
      expect(Geracao::X_GENERATION).to eq(1)
      expect(Geracao::Y_GENERATION).to eq(2)
      expect(Geracao::Z_GENERATION).to eq(3)
    end
  end
end
