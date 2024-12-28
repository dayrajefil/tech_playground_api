# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportCsvService do
  let(:valid_file) { fixture_file_upload('valid_feedback.csv', 'text/csv') }
  let(:invalid_file) { fixture_file_upload('invalid_feedback.csv', 'text/csv') }

  let(:row) { build(:csv_row) }

  describe '#import' do
    context 'with a valid CSV file' do
      it 'imports all rows successfully' do
        service = described_class.new(valid_file)

        # rubocop:disable Layout/MultilineMethodCallIndentation
        expect do
          service.import
        end.to change(Pessoa, :count).by(5)
                .and change(Organizacao, :count).by(5)
                .and change(Retorno, :count).by(5)
        # rubocop:enable Layout/MultilineMethodCallIndentation

        expect(service.errors).to be_empty
      end
    end

    context 'with an invalid CSV file' do
      it 'does not create any records and adds errors' do
        service = described_class.new(invalid_file)

        expect { service.import }.not_to change(Pessoa, :count)
        expect { service.import }.not_to change(Organizacao, :count)
        expect { service.import }.not_to change(Retorno, :count)

        expect(service.errors).not_to be_empty
      end
    end
  end

  describe '#create_pessoa' do
    it 'creates a valid pessoa record' do
      service = described_class.new(valid_file)

      pessoa = service.create_pessoa(row)

      expect(pessoa).to be_persisted
      expect(pessoa.nome).to eq('Nova Linha')
    end

    it 'adds errors when the pessoa is invalid' do
      row['email'] = nil
      service = described_class.new(valid_file)

      pessoa = service.create_pessoa(row)

      expect(pessoa).not_to be_valid
      expect(pessoa.errors).not_to be_empty
    end
  end

  describe '#create_retorno' do
    let(:pessoa) { create(:pessoa, :valid) }

    it 'creates a valid retorno record' do
      service = described_class.new(valid_file)

      retorno = service.create_retorno(pessoa, row)

      expect(retorno).to be_persisted
      expect(retorno.interesse_no_cargo).to eq(7)
      expect(retorno.comentario_interesse_no_cargo).to eq('Comentário Interesse')
    end

    it 'adds errors when the retorno is invalid' do
      row['Interesse no Cargo'] = nil
      service = described_class.new(valid_file)

      retorno = service.create_retorno(pessoa, row)

      expect(retorno).not_to be_valid
      expect(retorno.errors).not_to be_empty
    end
  end

  describe '#create_organizacao' do
    let(:pessoa) { create(:pessoa, :valid) }

    it 'creates a valid organizacao record' do
      service = described_class.new(valid_file)

      organizacao = service.create_organizacao(pessoa, row)

      expect(organizacao).to be_persisted
      expect(organizacao.n0_empresa).to eq('empresa')
      expect(organizacao.n1_diretoria).to eq('diretoria')
    end

    it 'adds errors when the organizacao is invalid' do
      row['n0_empresa'] = nil
      service = described_class.new(valid_file)

      organizacao = service.create_organizacao(pessoa, row)

      expect(organizacao).not_to be_valid
      expect(organizacao.errors).not_to be_empty
    end
  end

  describe '#add_errors_to_collection' do
    it 'collects errors for invalid records' do
      service = described_class.new(valid_file)
      pessoa = Pessoa.new
      pessoa.save

      service.send(:add_errors_to_collection, pessoa, nil, nil)

      expect(service.errors).not_to be_empty
    end
  end

  describe '#pessoa_attributes' do
    let(:service) { described_class.new(valid_file) }
    let(:attributes) { service.send(:pessoa_attributes, row) }

    it 'returns the correct nome' do
      expect(attributes[:nome]).to eq('Nova Linha')
    end

    it 'returns a valid email format' do
      expect(attributes[:email]).to match(/nova\.linha\d+@email\.com/)
    end

    it 'returns a valid email_corporativo format' do
      expect(attributes[:email_corporativo]).to match(/nova\.linha\d+@empresa\.com/)
    end

    it 'returns the correct area' do
      expect(attributes[:area]).to eq(2)
    end

    it 'returns the correct cargo' do
      expect(attributes[:cargo]).to eq(1)
    end

    it 'returns the correct funcao' do
      expect(attributes[:funcao]).to eq(1)
    end

    it 'returns the correct localidade' do
      expect(attributes[:localidade]).to eq(4)
    end

    it 'returns the correct tempo_de_empresa' do
      expect(attributes[:tempo_de_empresa]).to eq(1)
    end

    it 'returns the correct genero' do
      expect(attributes[:genero]).to eq(1)
    end

    it 'returns the correct geracao' do
      expect(attributes[:geracao]).to eq(2)
    end
  end

  describe '#retorno_attributes' do
    let(:service) { described_class.new(valid_file) }
    let(:pessoa) { create(:pessoa, :valid) }
    let(:attributes) { service.send(:retorno_attributes, pessoa, row) }

    it 'returns the correct pessoa_id' do
      expect(attributes[:pessoa_id]).to eq(pessoa.id)
    end

    it 'returns the correct data_da_resposta' do
      expect(attributes[:data_da_resposta]).to eq('15/12/2023'.to_date)
    end

    it 'returns the correct interesse_no_cargo' do
      expect(attributes[:interesse_no_cargo]).to eq(7)
    end

    it 'returns the correct comentario_interesse_no_cargo' do
      expect(attributes[:comentario_interesse_no_cargo]).to eq('Comentário Interesse')
    end

    it 'returns the correct contribuicao' do
      expect(attributes[:contribuicao]).to eq(8)
    end

    it 'returns the correct comentario_contribuicao' do
      expect(attributes[:comentario_contribuicao]).to eq('Comentário Contribuição')
    end

    it 'returns the correct aprendizado_e_desenvolvimento' do
      expect(attributes[:aprendizado_e_desenvolvimento]).to eq(6)
    end

    it 'returns the correct comentarios_aprendizado_e_desenvolvimento' do
      expect(attributes[:comentarios_aprendizado_e_desenvolvimento]).to eq('Comentário Aprendizado')
    end

    it 'returns the correct feedback' do
      expect(attributes[:feedback]).to eq(9)
    end

    it 'returns the correct comentario_feedback' do
      expect(attributes[:comentario_feedback]).to eq('Comentário Feedback')
    end

    it 'returns the correct interacao_com_gestor' do
      expect(attributes[:interacao_com_gestor]).to eq(8)
    end

    it 'returns the correct comentario_interacao_com_gestor' do
      expect(attributes[:comentario_interacao_com_gestor]).to eq('Comentário Interação')
    end

    it 'returns the correct clareza_sobre_possibilidades_de_carreira' do
      expect(attributes[:clareza_sobre_possibilidades_de_carreira]).to eq(7)
    end

    it 'returns the correct comentario_clareza_sobre_possibilidades_de_carreira' do
      expect(attributes[:comentario_clareza_sobre_possibilidades_de_carreira]).to eq('Comentário Clareza')
    end

    it 'returns the correct expectativa_de_permanencia' do
      expect(attributes[:expectativa_de_permanencia]).to eq(9)
    end

    it 'returns the correct comentario_expectativa_de_permanencia' do
      expect(attributes[:comentario_expectativa_de_permanencia]).to eq('Comentário Expectativa')
    end

    it 'returns the correct enps' do
      expect(attributes[:enps]).to eq(8)
    end

    it 'returns the correct comentario_enps' do
      expect(attributes[:comentario_enps]).to eq('Comentário eNPS')
    end
  end

  describe '#organizacao_attributes' do
    let(:service) { described_class.new(valid_file) }
    let(:pessoa) { create(:pessoa, :valid) }
    let(:attributes) { service.send(:organizacao_attributes, pessoa, row) }

    it 'returns the correct pessoa_id' do
      expect(attributes[:pessoa_id]).to eq(pessoa.id)
    end

    it 'returns the correct n0_empresa' do
      expect(attributes[:n0_empresa]).to eq('empresa')
    end

    it 'returns the correct n1_diretoria' do
      expect(attributes[:n1_diretoria]).to eq('diretoria')
    end

    it 'returns the correct n2_gerencia' do
      expect(attributes[:n2_gerencia]).to eq('gerência')
    end

    it 'returns the correct n3_coordenacao' do
      expect(attributes[:n3_coordenacao]).to eq('coordenação')
    end

    it 'returns the correct n4_area' do
      expect(attributes[:n4_area]).to eq('área')
    end
  end
end
