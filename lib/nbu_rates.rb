# frozen_string_literal: true

require_relative 'nbu_rates/version'

require 'open-uri'
require 'nokogiri'
require 'money'

Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN

class NbuRates
  attr_reader :refreshed_at
  
  def initialize(date = nil)
    @refreshed_at = Time.now
    
    parse!
  end

  def rate(currency_code)
    @rates[currency_code.upcase]
  end

  def exchange(money, currency_to)
    currency_from = money.currency.iso_code
    money.with_currency(currency_to) * rate(currency_from)
  end

  private

  def parse!
    response = URI.open('https://bank.gov.ua/NBU_Exchange/exchange?date=19.12.2017').read
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
    @rates = result.to_h
  end
end


# CurrencyCodeL
# Money в грн
# 