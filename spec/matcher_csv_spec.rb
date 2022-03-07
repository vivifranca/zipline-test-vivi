# frozen_string_literal: true

RSpec.describe MatcherCsv do
  describe '.read' do
    let(:csv_path) { File.join(__dir__, '/fixtures/input.csv') }

    subject { described_class.read(csv_path) }

    context 'when it is a valid file' do
      it 'returns the rows' do
        rows = subject

        expect(rows.count).to eq(6)
        expect(rows.first.keys).to match_array(%w[FirstName LastName Phone1 Phone2 Email1 Email2 Zip])
      end
    end

    context 'when the file does not exist' do
      let(:csv_path) { 'foo' }

      it 'raises an error' do
        expect { subject }.to raise_error('File does not exist')
      end
    end
  end

  describe '.write' do
    let(:csv_path) { File.join(__dir__, '/fixtures/output.csv') }
    let(:csv_content) do
      [{
        'Name': 'John', 'Phone': '(123) 123 1234', 'Email': 'John@email.com'
      }]
    end

    before { allow(File).to receive(:write) }

    subject { described_class.write(csv_path, csv_content) }

    context 'when the path and rows are valid' do
      let(:expected_csv_content) { "Name,Phone,Email\nJohn,(123) 123 1234,John@email.com\n" }

      it 'creates a new csv file' do
        expect(File).to receive(:write).with(csv_path, expected_csv_content)

        subject
      end
    end

    context 'when csv content is empty' do
      let(:csv_content) { [] }

      it 'raises an error' do
        expect { subject }.to raise_error('Output CSV content is empty')
      end
    end
  end
end
