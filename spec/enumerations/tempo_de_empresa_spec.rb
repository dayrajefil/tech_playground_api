require 'enumerate_it'
require 'rails_helper'

RSpec.describe TempoDeEmpresa do
  describe '.associate_values' do
    it 'associates the correct keys' do
      expect(TempoDeEmpresa.enumeration.keys).to eq(%i[
        less_than_one between_one_and_two between_two_and_five more_than_five
      ])
    end

    it 'associates the correct values' do
      expect(TempoDeEmpresa::LESS_THAN_ONE).to eq(0)
      expect(TempoDeEmpresa::BETWEEN_ONE_AND_TWO).to eq(1)
      expect(TempoDeEmpresa::BETWEEN_TWO_AND_FIVE).to eq(2)
      expect(TempoDeEmpresa::MORE_THAN_FIVE).to eq(3)
    end
  end
end
