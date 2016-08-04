# coding: utf-8

require 'active_record'

class Portfolio < ActiveRecord::Base
  has_many :transactions
  has_many :tracked_values
end
