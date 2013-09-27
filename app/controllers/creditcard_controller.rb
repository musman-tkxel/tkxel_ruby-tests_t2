class CreditcardController < ApplicationController

  attr_accessor :card_num, :isValid



  def check_validation
    @card_num = params['account_num']


      @isValid = credit_card_valid? @card_num
      render "result"

  end

  def result
      @card_num
      @isValid
  end

  def credit_card_valid?(account_number)
    digits = account_number.scan(/./).map(&:to_i)
    check = digits.pop

    sum = digits.reverse.each_slice(2).map do |x, y|
      [(x * 2).divmod(10), y]
    end.flatten.inject(:+)

    (10 - sum % 10) == check
  end

end
