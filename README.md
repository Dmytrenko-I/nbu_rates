# NBU Rates

Gem for fetching currency from National bank of Ukraine

Gem done by [this tutorial](https://www.youtube.com/watch?v=rTRzXBWGmvI) from [GoodProgrammer](https://www.youtube.com/channel/UCDPdTky4sQtQEwOLAe5v-NA)

This is a version to parse XML response. Version to parse JSON you can find at `nbu_json` branch. 

## Installation

Add this line to your application's Gemfile:

```rb
gem 'nbu_rates'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install nbu_rates

## Usage

``` rb
require 'cbr_rates'

usd = Money.new('1_50', 'USD')

result = CbrRates.new.exchange(usd, 'CAD')

puts "1.50 USD ~> CAD: #{result.format}"
```

How to work with object `Money`: [documentation](https://github.com/RubyMoney/money)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Dmytrenko-I/nbu_rates.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
