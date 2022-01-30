# frozen_string_literal: true

require_relative 'nbu_rates/version'

require 'open-uri'
require 'nokogiri'
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
    date = date.strftime('%d.%m.%Y')
    url = "https://bank.gov.ua/NBU_Exchange/exchange?date=#{date}"
    
    response = URI.open(url).read
    xml_doc = Nokogiri::XML(response)

    result = 
      xml_doc.css('ROW').map do |node| 
        # amount -- price in UAH per X units
        # units -- quantity of valute
        amount = BigDecimal(node.css('Amount').text, 10)
        units = node.css('Units').text.to_i
        [
          node.css('CurrencyCodeL').text, 
          amount / units
        ]
      end

    result.push(['UAH', 1])

    @rates = result.to_h
  end
end
