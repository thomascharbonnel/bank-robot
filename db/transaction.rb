# coding: utf-8

require 'active_record'

module StockExchangeRobot
  class Transaction < ActiveRecord::Base
    has_one :portfolio
  end
end
