# coding: utf-8

require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'data.db')

require_relative 'portfolio'
require_relative 'transaction'
require_relative 'quote'
require_relative 'tracked_value'
