require 'rails_helper'

RSpec.describe ImportCsvService do
  let(:valid_file) { fixture_file_upload('valid_feedback.csv', 'text/csv') }
  let(:invalid_file) { fixture_file_upload('invalid_feedback.csv', 'text/csv') }

  let(:row) { build(:csv_row) }

  describe '#import' do
    context 'with a valid CSV file' do
      it 'imports all rows successfully' do
        service = ImportCsvService.new(valid_file)

        expect {
          service.import
        }.to change(Pessoa, :count).by(5)
        .and change(Organizacao, :count).by(5)
        .and change(Retorno, :count).by(5)

        expect(service.errors).to be_empty
      end
    end

    context 'with an invalid CSV file' do
      it 'does not create any records and adds errors' do
        service = ImportCsvService.new(invalid_file)

        expect {
          service.import
        }.not_to change(Pessoa, :count)

        expect {
          service.import
        }.not_to change(Organizacao, :count)

        expect {
          service.import
        }.not_to change(Retorno, :count)

        expect(service.errors).not_to be_empty
      end
    end
  end

  describe '#create_pessoa' do
    it 'creates a valid pessoa record' do
      service = ImportCsvService.new(valid_file)

      pessoa = service.create_pessoa(row)

      expect(pessoa).to be_persisted
      expect(pessoa.nome).to eq('Nova Linha')
    end

    it 'adds errors when the pessoa is invalid' do
      row['email'] = nil
      service = ImportCsvService.new(valid_file)

      pessoa = service.create_pessoa(row)

      expect(pessoa).not_to be_valid
      expect(pessoa.errors).not_to be_empty
    end
  end

  describe '#create_retorno' do
    let(:pessoa) { create(:pessoa, :valid) }

    it 'creates a valid retorno record' do
      service = ImportCsvService.new(valid_file)

      retorno = service.create_retorno(pessoa, row)

      expect(retorno).to be_persisted
      expect(retorno.interesse_no_cargo).to eq(7)
      expect(retorno.comentario_interesse_no_cargo).to eq('Comentário Interesse')
    end

    it 'adds errors when the retorno is invalid' do
      row['Interesse no Cargo'] = nil
      service = ImportCsvService.new(valid_file)

      retorno = service.create_retorno(pessoa, row)

      expect(retorno).not_to be_valid
      expect(retorno.errors).not_to be_empty
    end
  end

  describe '#create_organizacao' do
  let(:pessoa) { create(:pessoa, :valid) }

    it 'creates a valid organizacao record' do
      service = ImportCsvService.new(valid_file)

      organizacao = service.create_organizacao(pessoa, row)

      expect(organizacao).to be_persisted
      expect(organizacao.n0_empresa).to eq('empresa')
      expect(organizacao.n1_diretoria).to eq('diretoria')
    end

    it 'adds errors when the organizacao is invalid' do
      row['n0_empresa'] = nil
      service = ImportCsvService.new(valid_file)

      organizacao = service.create_organizacao(pessoa, row)

      expect(organizacao).not_to be_valid
      expect(organizacao.errors).not_to be_empty
    end
  end

  describe '#add_errors_to_collection' do
    it 'collects errors for invalid records' do
      service = ImportCsvService.new(valid_file)
      pessoa = Pessoa.new
      pessoa.save

      service.send(:add_errors_to_collection, pessoa, nil, nil)

      expect(service.errors).not_to be_empty
    end
  end

  describe '#pessoa_attributes' do
    it 'returns a hash with the correct attributes' do
      service = ImportCsvService.new(valid_file)

      attributes = service.send(:pessoa_attributes, row)

      expect(attributes[:nome]).to eq("Nova Linha")
      expect(attributes[:email]).to match(/nova\.linha\d+@email\.com/)
      expect(attributes[:email_corporativo]).to match(/nova\.linha\d+@empresa\.com/)
      expect(attributes[:area]).to eq(2)
      expect(attributes[:cargo]).to eq(1)
      expect(attributes[:funcao]).to eq(1)
      expect(attributes[:localidade]).to eq(4)
      expect(attributes[:tempo_de_empresa]).to eq(1)
      expect(attributes[:genero]).to eq(1)
      expect(attributes[:geracao]).to eq(2)
    end
  end

  describe '#retorno_attributes' do
    it 'returns a hash with the correct attributes' do
      pessoa = create(:pessoa, :valid)
      service = ImportCsvService.new(valid_file)

      attributes = service.send(:retorno_attributes, pessoa, row)

      expect(attributes[:pessoa_id]).to eq(pessoa.id)
      expect(attributes[:data_da_resposta]).to eq(('15/12/2023').to_date)
      expect(attributes[:interesse_no_cargo]).to eq(7)
      expect(attributes[:comentario_interesse_no_cargo]).to eq('Comentário Interesse')
      expect(attributes[:contribuicao]).to eq(8)
      expect(attributes[:comentario_contribuicao]).to eq('Comentário Contribuição')
      expect(attributes[:aprendizado_e_desenvolvimento]).to eq(6)
      expect(attributes[:comentarios_aprendizado_e_desenvolvimento]).to eq('Comentário Aprendizado')
      expect(attributes[:feedback]).to eq(9)
      expect(attributes[:comentario_feedback]).to eq('Comentário Feedback')
      expect(attributes[:interacao_com_gestor]).to eq(8)
      expect(attributes[:comentario_interacao_com_gestor]).to eq('Comentário Interação')
      expect(attributes[:clareza_sobre_possibilidades_de_carreira]).to eq(7)
      expect(attributes[:comentario_clareza_sobre_possibilidades_de_carreira]).to eq('Comentário Clareza')
      expect(attributes[:expectativa_de_permanencia]).to eq(9)
      expect(attributes[:comentario_expectativa_de_permanencia]).to eq('Comentário Expectativa')
      expect(attributes[:enps]).to eq(8)
      expect(attributes[:comentario_enps]).to eq('Comentário eNPS')
    end
  end

  describe '#organizacao_attributes' do
    it 'returns a hash with the correct attributes' do
      pessoa = create(:pessoa, :valid)
      service = ImportCsvService.new(valid_file)

      attributes = service.send(:organizacao_attributes, pessoa, row)

      expect(attributes[:pessoa_id]).to eq(pessoa.id)
      expect(attributes[:n0_empresa]).to eq('empresa')
      expect(attributes[:n1_diretoria]).to eq('diretoria')
      expect(attributes[:n2_gerencia]).to eq('gerência')
      expect(attributes[:n3_coordenacao]).to eq('coordenação')
      expect(attributes[:n4_area]).to eq('área')
    end
  end
end
