# coding: utf-8

require 'active_record'

class TrackedValue < ActiveRecord::Base
  has_one :portfolio
end
