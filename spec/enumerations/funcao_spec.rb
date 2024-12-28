require 'enumerate_it'
require 'rails_helper'

RSpec.describe Funcao do
  describe '.associate_values' do
    it 'associates the correct keys' do
      expect(Funcao.enumeration.keys).to eq(%i[
        manager professional
      ])
    end

    it 'associates the correct values' do
      expect(Funcao::MANAGER).to eq(0)
      expect(Funcao::PROFESSIONAL).to eq(1)
    end
  end
end
