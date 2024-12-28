require 'enumerate_it'
require 'rails_helper'

RSpec.describe Cargo do
  describe '.associate_values' do
    it 'associates the correct keys' do
      expect(Cargo.enumeration.keys).to eq(%i[
        intern analyst coordinator manager director
      ])
    end

    it 'associates the correct values' do
      expect(Cargo::INTERN).to eq(0)
      expect(Cargo::ANALYST).to eq(1)
      expect(Cargo::COORDINATOR).to eq(2)
      expect(Cargo::MANAGER).to eq(3)
      expect(Cargo::DIRECTOR).to eq(4)
    end
  end
end
