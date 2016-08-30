# coding: utf-8

require 'active_record'

module StockExchangeRobot
  class BankInterface < ActiveRecord::Base; end

  class Quote < ActiveRecord::Base
    self.connection

    belongs_to :bank, class_name: 'BankInterface'
  end
end
