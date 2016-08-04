# coding: utf-8

require 'active_record'

class Transaction < ActiveRecord::Base
  has_one :portfolio
end
