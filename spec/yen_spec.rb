require "spec_helper"

RSpec.describe Yen do
  describe '税率が同じ場合' do
    it '1800 > 1000' do
      expect(Yen::Currency.new(1800) > Yen::Currency.new(1000)).to be true
    end

    it '"1800" > 1000' do
      expect(Yen::Currency.new('1800') > Yen::Currency.new(1000)).to be true
    end

    it '1000 = 1000' do
      expect(Yen::Currency.new(1000) == Yen::Currency.new(1000)).to be true
    end

    it '1800 + 1000 = 2800' do
      a = Yen::Currency.new(1800)
      b = Yen::Currency.new(1000)
      expect((a + b) == Yen::Currency.new(2800)).to be true
    end

    it '1800 - 1000 = 800' do
      a = Yen::Currency.new(1800)
      b = Yen::Currency.new(1000)
      expect((a - b) == Yen::Currency.new(800)).to be true
    end

    it '1800 * 2 = 3600' do
      a = Yen::Currency.new(1800)
      expect((a * 2) == Yen::Currency.new(3600)).to be true
    end

    it '1800 / 2 = 900' do
      a = Yen::Currency.new(1800)
      expect((a / 2) == Yen::Currency.new(900)).to be true
    end
  end

  describe '異なる税率の場合' do

  end
end
