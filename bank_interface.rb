# coding: utf-8

# Defines the bank interface abstract class used to model an abstract interface
# to any bank.

require_relative 'exceptions'

class BankInterface
  attr_reader :cookies

  def connect; raise NoMethodError; end
  def index_quotes; raise NoMethodError; end
  def show_quote(isin); raise NoMethodError; end
end
