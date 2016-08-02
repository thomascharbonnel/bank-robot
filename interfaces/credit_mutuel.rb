# coding: utf-8

# Bank Interface for French bank Credit Mutuel.

require 'mechanize'
require 'json'

require_relative '../exceptions'
require_relative '../bank_interface'

module StockExchangeRobot
  class CreditMutuelBankInterface < BankInterface

    def initialize
      @mechanize = Mechanize.new

      settings_file = File.open('SECRETS.json')
      settings = JSON.parse(settings_file.read)

      @pea_id = settings['pea_id']

      home_page = mechanize.get('https://www.creditmutuel.fr')
      form = home_page.forms.first
      form['_cm_user'] = settings['id']
      form['_cm_pwd'] = settings['password']
      page = form.submit

      # TODO: check the answer to be sure that we're connected.

      # Now we are connected.
    rescue Errno::ENOENT => e
      STDERR.puts "SECRETS.json file does not exist and is needed: #{e}"
      raise UnableToConnectException
    end

    def index_quotes # TODO
      pea_url = "https://www.creditmutuel.fr/cmmabn/fr/banque/POR_ValoToute.aspx?DosTit=#{@pea_id}"

      puts @mechanize.get(pea_url).links_with(href: /VAL_FicheCours.aspx/)
    end
  end
end
