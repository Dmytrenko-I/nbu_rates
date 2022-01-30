# frozen_string_literal: true

require_relative 'nbu_rates/version'

require 'open-uri'
require 'money'

Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN
Money.locale_backend = :currency

class NbuRates
  attr_reader :refreshed_at
  
  def initialize(date = Date.today)
    @refreshed_at = Time.now
    
    parse!(date)
  end

  def rate(currency_code)
    @rates[currency_code.upcase]
  end

  def exchange(money, currency_to)
    currency_from = money.currency.iso_code
    
    money.with_currency(currency_to) * rate(currency_from) / rate(currency_to)
  end

  private

  def parse!(date)
    date = date.strftime('%Y%m%d')
    url = "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?date=#{date}&json"
    
    response = URI.open(url).read
    json = JSON.parse(response)

    cc = json.map { |valute| valute['cc'] }
    money_rate = json.map { |valute| valute['rate'] }
    result = cc.zip(money_rate)
    result.push(['UAH', 1])

    @rates = result.to_h
  end
end
