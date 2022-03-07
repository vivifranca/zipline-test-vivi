# frozen_string_literal: true

RSpec.describe Matcher do
  describe '.call' do
    let!(:csv_records) { MatcherCsv.read(File.join(__dir__, '/fixtures/input.csv')) }

    subject { described_class.call(csv_records, matching_type) }

    context 'when the matcher is email' do
      let(:matching_type) { [:email] }

      it 'returns exactly unique ids' do
        ids = subject.map { |item| item['id'] }

        expect(ids.count).to eq(6)
        expect(ids.uniq.count).to eq(3)
      end
    end

    context 'when the matcher is phone' do
      let(:matching_type) { [:phone] }

      it 'returns exactly unique ids' do
        ids = subject.map { |item| item['id'] }

        expect(ids.count).to eq(6)
        expect(ids.uniq.count).to eq(3)
      end
    end

    context 'when the matcher is phone or email' do
      let(:matching_type) { %i[email phone] }

      it 'returns exactly 2 unique ids' do
        ids = subject.map { |item| item['id'] }

        expect(ids.count).to eq(6)
        expect(ids.uniq.count).to eq(2)
      end
    end

    context 'when the matcher does not exist' do
      let(:matching_type) { [:foo] }

      it 'raises an exception' do
        expect { subject }.to raise_error('Invalid matchers')
      end
    end
  end
end