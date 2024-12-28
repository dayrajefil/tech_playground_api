require 'enumerate_it'
require 'rails_helper'

RSpec.describe Localidade do
  describe '.associate_values' do
    it 'associates the correct keys' do
      expect(Localidade.enumeration.keys).to eq(%i[
        brasilia manaus porto_alegre recife sao_paulo
      ])
    end

    it 'associates the correct values' do
      expect(Localidade::BRASILIA).to eq(0)
      expect(Localidade::MANAUS).to eq(1)
      expect(Localidade::PORTO_ALEGRE).to eq(2)
      expect(Localidade::RECIFE).to eq(3)
      expect(Localidade::SAO_PAULO).to eq(4)
    end
  end
end
