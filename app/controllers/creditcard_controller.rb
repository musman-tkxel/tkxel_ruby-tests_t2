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
      s1 = s2 = 0
      account_number.to_s.reverse.chars.each_slice(2) do |odd, even|
        s1 += odd.to_i
        double = even.to_i * 2
        double -= 9 if double >= 10
        s2 += double
      end
      (s1 + s2) % 10 == 0
  rescue => e
    "In-Valid Combination"
  end
  end

  def find_check_sum?(account_number)
  begin
    temp = account_number.to_s + "0"
    s1 = s2 = 0
    temp.to_s.reverse.chars.each_slice(2) do |odd, even|
      s1 += odd.to_i
      double = even.to_i * 2
      double -= 9 if double >= 10
      s2 += double
    end
    if (s1 + s2) % 10 == 0
      0
    else
      10 - ((s1 + s2) % 10)
    end
  rescue => e
      "In-Valid Combination"
  end

  end

end
