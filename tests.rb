# coding: utf-8

require 'minitest/autorun'

require_relative 'exceptions'
require_relative 'bank_interface'

describe StockExchangeRobot::BankInterface do
  before do
    @bi = StockExchangeRobot::BankInterface.new
  end

  describe "when calling abstract methods from BankInterface" do
    it "should raise an UnimplementedBankInterfaceException exception" do
      # All three methods must raise the exception.
      assert_raises(StockExchangeRobot::BankInterface::UnimplementedBankInterfaceException) { @bi.connect }
      assert_raises(StockExchangeRobot::BankInterface::UnimplementedBankInterfaceException) { @bi.index_quotes }
      assert_raises(StockExchangeRobot::BankInterface::UnimplementedBankInterfaceException) { @bi.show_quote(nil) }
    end
  end
end
