#!/usr/bin/env ruby
# coding: utf-8

require 'active_support'
require 'pp'

require_relative 'bank_interface'

module StockExchangeRobot
  def self.update_database
    banks = Dir['./interfaces/*.rb'].map do |f|
      puts "Loading #{f}."
      require_relative f
      StockExchangeRobot.const_get(f[/.\/interfaces\/([a-zA-Z0-9_-]*).rb/,1].split('_').map(&:capitalize).join + 'BankInterface').new
    end

    puts "Retrieving stocks."

    # We retrieve all the quotes for each symbol from each bank.
    # TODO: do something with it.
    banks.each do |bank|
      bank.index_symbols.each do |symbol|
        bank.get_quotes(symbol)
      end
    end
  end
end

if __FILE__ == $0
  StockExchangeRobot.update_database
end
