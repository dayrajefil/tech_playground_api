# spec/enums/enum_methods_spec.rb
require 'rails_helper'

RSpec.describe EnumMethods do
  before do
    stub_const('GenericEnum', Class.new(EnumMethods))
    GenericEnum.associate_values(
      op_one: 0,
      op_two: 1,
      op_three: 2
    )

    I18n.backend.store_translations(:"pt-BR", {
      enumerations: {
        generic_enum: {
          op_one: 'Primeira',
          op_two: 'Segunda',
          op_three: 'Terceira'
        }
      }
    })
  end

  describe '.value_from_translation' do
    context 'when the translation exists' do
      it 'returns the correct value for the translation' do
        expect(GenericEnum.value_from_translation('Primeira')).to eq(0)
        expect(GenericEnum.value_from_translation('Segunda')).to eq(1)
        expect(GenericEnum.value_from_translation('Terceira')).to eq(2)
      end
    end

    context 'when the translation does not exist' do
      it 'returns nil for a non-existent translation' do
        expect(GenericEnum.value_from_translation('NonExistent')).to be_nil
      end
    end

    context 'when the translation is case-insensitive' do
      it 'returns the correct value for the translation in any case' do
        expect(GenericEnum.value_from_translation('primeira')).to eq(0)
        expect(GenericEnum.value_from_translation('segunda')).to eq(1)
      end
    end
  end
end
