class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================



    @character_count_with_spaces = @text.length



    @character_count_without_spaces = @text.gsub(/[\s\n]/, "").length

    no_punctuation = @text.gsub(/[.?,!]/, "")

    word_array = no_punctuation.split

    @word_count = word_array.length
    special_word_downcase = @special_word.downcase

    count = 0
    word_array.each do |word|
      word.downcase!
      if word == special_word_downcase
        count+=1
      end
    end

    @occurrences = count

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    rate = @apr / 1200
    months = @years *  12
    @monthly_payment = @principal * (rate + (rate / ((1+rate) ** months - 1) ) )

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @weeks / 52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[-1]

    @range = @maximum - @minimum

    if @count % 2 == 0
      median = (@sorted_numbers[@count / 2 - 1] + @sorted_numbers[@count / 2]) / 2
    else
      median = @sorted_numbers[@count/2]
    end

    @median = median

    @sum = @numbers.sum

    @mean = @sum / @count

    variance_list = @numbers.map {|a| (a - @mean) ** 2 }

    @variance = variance_list.sum / @count

    @standard_deviation = Math.sqrt(@variance)

    count = -1
    mode = @sorted_numbers[0]

    test_count = -1
    test_mode = @sorted_numbers[0]


    @sorted_numbers.each do |num|
      if num == test_mode #in a streak, add 1
        test_count+=1
      else #new number
        if test_count > count #check if we have a new mode
          mode = test_mode
          count = test_count
        end
        test_count = 1 #reset for the next number
        test_mode = num
      end
    end



    @mode = mode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
