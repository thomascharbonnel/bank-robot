# coding: utf-8

require 'active_record'

module StockExchangeRobot
  db_file_path = File.expand_path('./data.db', __dir__)
  ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: db_file_path)

  require_relative 'portfolio'
  require_relative 'transaction'
  require_relative 'quote'
  require_relative 'tracked_value'
end
