# frozen_string_literal: true

require 'enumerate_it'
require 'rails_helper'

RSpec.describe Funcao do
  describe '.associate_values' do
    it 'associates the correct keys' do
      expect(described_class.enumeration.keys).to eq(%i[
                                                       manager professional
                                                     ])
    end

    it 'associates the correct values' do
      expect(Funcao::MANAGER).to eq(0)
      expect(Funcao::PROFESSIONAL).to eq(1)
    end
  end
end
