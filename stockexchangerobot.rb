#!/usr/bin/env ruby
# coding: utf-8

require 'mechanize'
require 'pp'

ID = 'xxx'
PWD = 'xxx'

PEA_URL = 'https://www.creditmutuel.fr/cmmabn/fr/banque/POR_ValoToute.aspx?DosTit=xxx'

mechanize = Mechanize.new
home_page = mechanize.get('https://www.creditmutuel.fr')
form = home_page.forms.first
form['_cm_user'] = ID
form['_cm_pwd'] = PWD
page = form.submit

# Now we're connected.

pp mechanize.get(PEA_URL).links_with(href: /VAL_FicheCours.aspx/)
