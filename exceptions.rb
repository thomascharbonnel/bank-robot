# coding: utf-8

# Defines all the exceptions used throughout the program.

require 'active_record'

module StockExchangeRobot
  class BankInterface < ActiveRecord::Base
    class UnimplementedBankInterfaceException < Exception; "Unimplemented bank interface."; end
    class UnableToConnectException < Exception; "Unable to connect to bank interface."; end
    class WrongBankSymbol < Exception; "Symbol is not compatible with this bank interface."; end
  end
end
