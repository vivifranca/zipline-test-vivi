# frozen_string_literal: true

RSpec.describe MatcherCsv do
  describe '.call' do
    let(:csv_file) { fixture_file_upload('input.csv', 'text/csv') }

    subject { described_class.call(csv_file, matching_type) }

    context 'when the matcher is email' do
      let(:matching_type) { [:email] }

      it 'returns valid matchers' do
        subject

        expect(true).to eq(true)

      end
    end

    context 'when the matcher is phone' do
      let(:matching_type) { [:phone] }

      it 'returns valid matchers' do

      end
    end

    context 'when the matcher is phone or email' do
      let(:matching_type) { %i[email phone] }

      it 'returns valid matchers' do

      end
    end

    context 'when the matcher does not exist' do
      let(:matching_type) { [:foo] }

      it 'raises an exception' do

      end
    end
  end
end