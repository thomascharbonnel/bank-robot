#!/usr/bin/env ruby
# coding: utf-8

require 'sqlite3'

TABLES = [
  "banks(id INTEGER PRIMARY KEY, name TEXT)",
  "portfolios(id INTEGER PRIMARY KEY, name TEXT, owner TEXT, adapter TEXT)", # ex. nil, 'Test', 'Computer', 'Crédit Mutuel'
  "transactions(id INTEGER PRIMARY KEY, isin TEXT, date DATETIME, price DECIMAL, amount DECIMAL, buy BOOLEAN, portfolio_id INTEGER, FOREIGN KEY(portfolio_id) REFERENCES portfolios(id))",
  "quotes(id INTEGER PRIMARY KEY, isin TEXT, date DATETIME, bank_id INTEGER, price DECIMAL, volume INTEGER, FOREIGN KEY(bank_id) REFERENCES banks(id))",
  "tracked_values(id INTEGER PRIMARY KEY, isin TEXT, portfolio_id INTEGER, FOREIGN KEY(portfolio_id) REFERENCES portfolios(id))"
]

begin
  File.delete 'data.db'
  db = SQLite3::Database.open 'data.db'

  TABLES.each do |table|
    db.execute "CREATE TABLE #{table};"
  end
rescue SQLite3::Exception => e
  puts e
ensure
  db.close if db
end

