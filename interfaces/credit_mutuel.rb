# coding: utf-8

# Bank Interface for French bank Credit Mutuel.

require 'mechanize'
require 'json'

require_relative '../exceptions'
require_relative '../bank_interface'

module StockExchangeRobot
  class CreditMutuelBankSymbol < BankSymbol
    attr_accessor :place
  end

  class CreditMutuelBankInterface < BankInterface
    @@name = 'Crédit Mutuel'

    def initialize
      super

      self.class.superclass.set_bank_id

      @mechanize = Mechanize.new

      settings_file = File.open('SECRETS.json')
      settings = JSON.parse(settings_file.read)

      @pea_id = settings['pea_id']

      home_page = @mechanize.get('https://www.creditmutuel.fr')
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

    def index_symbols
      pea_url = "https://www.creditmutuel.fr/cmmabn/fr/banque/POR_ValoToute.aspx?DosTit=#{@pea_id}"

      @mechanize.get(pea_url).links_with(href: /VAL_FicheCours.aspx/).reduce([]) do |memo, l|
        symbol = CreditMutuelBankSymbol.new
        symbol.bank = self
        symbol.isin, symbol.place = l.href.match(/&isin=([A-Z0-9]*)&place=([0-9]*)/).captures
        symbol.name = l.text
        memo + [symbol]
      end
    end

    # TODO after and before not implemented
    def get_quotes(symbol, after: nil, before: nil)
      raise WrongBankSymbol unless symbol.is_a?(CreditMutuelBankSymbol)

      url = "VAL_HistoriqueCours.aspx?contexte=#{symbol.isin}|#{symbol.place}||#{symbol.name}|||||||"
      quotes_table = @mechanize.get(url).css('table#TBL_MereFille table')[3]

      dates = quotes_table.css('td.p.c, td.i.c').map(&:text)
      prices = quotes_table.css('td.p.d span, td.i.d span').map { |e| e.text.delete(' ').sub(',','.').to_f }
      volumes = quotes_table.css('td.p.d.nowrap, td.i.d.nowrap').map { |e| e.text.delete(' ').to_i }

      dates.zip(prices, volumes).map do |date, price, volume|
        quote = ::StockExchangeRobot::Quote.new(bank: @@bank, date: date, price: price, volume: volume, isin: symbol.isin)
      end
    end
  end
end
