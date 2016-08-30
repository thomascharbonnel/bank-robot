# coding: utf-8

# Defines the bank interface abstract class used to model an abstract interface
# to any bank.

require 'active_record'

require_relative 'exceptions'
require_relative 'db/connection'
require_relative 'db/quote'

module StockExchangeRobot
  class BankInterface < ActiveRecord::Base
    @@name = @@bank = nil
    self.table_name = 'banks'
    self.connection

    has_many :quotes

    def index_symbols
      raise UnimplementedBankInterfaceException, "Unimplemented method index_quotes for interface #{self.class}."
    end

    def get_quotes(isin, atfer: nil, before: nil)
      raise UnimplementedBankInterfaceException, "Unimplemented method show_quotes(isin) for interface #{self.class}."
    end

    protected
    def self.set_bank_id
      @@bank = find_by(name: @@name) || create!(name: @@name)
    end

    def hash; @@name.hash; end
    def eql?(other); other.hash == hash; end
    def ==(other); other == self; end
  end

  class BankSymbol
    attr_accessor :isin, :name, :bank

    def to_s; "#{bank}: #{isin}"; end
  end
end
