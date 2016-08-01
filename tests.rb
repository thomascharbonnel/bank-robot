# coding: utf-8

require 'minitest/autorun'

require_relative 'exceptions'
require_relative 'bank_interface'

class TestBankInterface < Minitest::Test
  def setup
    @bi = StockExchangeRobot::BankInterface.new
  end

  def test_abstract_bank_interface_should_throw_exception
    assert_raises(StockExchangeRobot::BankInterface::UnimplementedBankInterfaceException) { @bi.connect }
    assert_raises(StockExchangeRobot::BankInterface::UnimplementedBankInterfaceException) { @bi.index_quotes }
    assert_raises(StockExchangeRobot::BankInterface::UnimplementedBankInterfaceException) { @bi.show_quote(nil) }
  end
end
