# frozen_string_literal: true

require 'enumerate_it'
require 'rails_helper'

RSpec.describe Genero do
  describe '.associate_values' do
    it 'associates the correct keys' do
      expect(described_class.enumeration.keys).to eq(%i[
                                                       other female male
                                                     ])
    end

    it 'associates the correct values' do
      expect(Genero::OTHER).to eq(0)
      expect(Genero::FEMALE).to eq(1)
      expect(Genero::MALE).to eq(2)
    end
  end
end
