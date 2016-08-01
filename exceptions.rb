# coding: utf-8

# Defines all the exceptions used throughout the program.

module StockExchangeRobot
  class BankInterface
    class UnimplementedBankInterfaceException < Exception; "Unimplemented bank interface."; end
  end
end
