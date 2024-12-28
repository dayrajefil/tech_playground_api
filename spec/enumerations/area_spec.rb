# frozen_string_literal: true

require 'enumerate_it'
require 'rails_helper'

RSpec.describe Area do
  describe '.associate_values' do
    it 'associates the correct keys' do
      expect(described_class.enumeration.keys).to eq(%i[
                                                       administrative commercial financial human_resources technology
                                                     ])
    end

    it 'associates the correct values' do
      expect(Area::ADMINISTRATIVE).to eq(0)
      expect(Area::COMMERCIAL).to eq(1)
      expect(Area::FINANCIAL).to eq(2)
      expect(Area::HUMAN_RESOURCES).to eq(3)
      expect(Area::TECHNOLOGY).to eq(4)
    end
  end
end
