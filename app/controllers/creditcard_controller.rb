class CreditcardController < ApplicationController

  attr_accessor :card_num, :isValid, :newCardNumber, :execute



  def check_validation

    @card_num = params['account_num']
    @execute =  params['commit']

    if (@execute == "VALIDATE CARD NUMBER")
      @isValid = credit_card_valid? @card_num
      @newCardNumber = false
    elsif (@execute == "APPEND CHECK SUM")
      @temp_result = find_check_sum? @card_num
      if(@temp_result.to_s.eql? "In-Valid Combination")
        @newCardNumber = "In-Valid Combination"
      else
        @newCardNumber = @card_num.to_s + @temp_result.to_s
      end
      @isValid = false
    end

    render "result"

  end


  def result
    @card_num
    @isValid
    @newCardNumber
  end


  def credit_card_valid?(account_number)
  begin

    if account_number.to_s.length == 0
      return
    end

    digits = account_number.scan(/./).map(&:to_i)
    check = digits.pop

    sum = digits.reverse.each_slice(2).map do |x, y|
      [(x * 2).divmod(10), y]
    end.flatten.inject(:+)

    (10 - sum % 10) == check
  rescue => e
    "In-Valid Combination"
  end
  end

  def find_check_sum?(account_number)
  begin
    digits = account_number.scan(/./).map(&:to_i)

    sum = digits.reverse.each_slice(2).map do |x, y|
      [(x * 2).divmod(10), y]
    end.flatten.inject(:+)


      (10 - sum % 10)
  rescue => e
      "In-Valid Combination"
  end

  end

end
