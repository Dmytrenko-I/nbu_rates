require_relative '../lib/nbu_rates'

usd = Money.new('1_50', 'USD')

result = NbuRates.new.exchange(usd, 'CAD')

puts "1.5 USD ~> CAD: #{result.format}"
