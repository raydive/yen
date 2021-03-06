# coding: utf-8
require 'bigdecimal'

module Yen
  class Currency
    include Comparable
    attr_reader :amount, :amount_without_tax, :tax, :tax_rate

    def initialize(amount_without_tax, tax_rate = TAX_RATE_8)
      raise "#{amount_without_tax} is not Numeric or String class" unless valid?(amount_without_tax)
      raise "#{tax_rate} is not Numeric or String class" unless valid?(tax_rate)

      setup(amount_without_tax, tax_rate)
      freeze
    end

    def +(other)
      self.class.new(@amount_without_tax + other.amount_without_tax, @tax_rate)
    end

    def -(other)
      self.class.new(@amount_without_tax - other.amount_without_tax, @tax_rate)
    end

    def *(times)
      raise "#{amount_without_tax} is not Numeric or String class" unless valid?(times)
      raise "#{tax_rate} is not Numeric or String class" unless valid?(times)

      self.class.new(@amount_without_tax * BigDecimal(times), @tax_rate)
    end

    def /(divided)
      raise "#{amount_without_tax} is not Numeric or String class" unless valid?(divided)
      raise "#{tax_rate} is not Numeric or String class" unless valid?(divided)

      self.class.new(@amount_without_tax / BigDecimal(divided), @tax_rate)
    end

    def <=>(other)
      @amount <=> other.amount
    end

    private
    def valid?(value)
      # Ruby 2.3以前ではクラス階層が Fixnum or Bignum => Integer => Numericになるため
      value.class.superclass.superclass == Numeric || value.class.superclass == Numeric || value.class == String
    end

    def setup(amount_without_tax, tax_rate)
      @amount_without_tax = BigDecimal(amount_without_tax)
      @tax_rate = BigDecimal(tax_rate)
      @amount = (@amount_without_tax * @tax_rate).ceil
      @tax    = @amount - @amount_without_tax
    end
  end
end
