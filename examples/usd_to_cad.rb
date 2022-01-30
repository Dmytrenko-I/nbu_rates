require 'open-uri'
require 'nokogiri'
require 'money'

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

result = result.to_h

pp result["AUD"].to_f