# frozen_string_literal: true

RSpec.describe NbuRates do
  let(:rates) { NbuRates.new }

  describe '#rate' do
    it 'return rate for given currency' do
      expect(rates.rate("USD")).to eq 27.873635
    end
  end

  describe '#exchange' do
    it 'converts another currency to UAH' do
      usd = Money.new('1_00', 'USD')

      result = rates.exchange(usd, 'UAH')

      expect(result).to eq Money.new(27_87, 'UAH')
    end

    # it 'converts one currency to another currency' do
    #   aud = Money.new('1_50', 'AUD')

    #   result = rates.exchange(aud, 'USD')

    #   expect(result).to eq Money.new(1_14, 'USD')
    # end
  end
end
