# coding: utf-8

# Defines the bank interface abstract class used to model an abstract interface
# to any bank.

require_relative 'exceptions'

module StockExchangeRobot
  class BankInterface
    def index_quotes
      raise UnimplementedBankInterfaceException, "Unimplemented method index_quotes for interface #{self.class}."
    end

    def show_quote(isin)
      raise UnimplementedBankInterfaceException, "Unimplemented method show_quotes(isin) for interface #{self.class}."
    end
  end
end
