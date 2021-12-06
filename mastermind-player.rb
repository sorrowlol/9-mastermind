# frozen_string_literal: true

class Mastermind
  # building mastermind from odin project

  def initialize
    @board = Array.new(12) { Array.new(4) { ' ' } }
    @secret_code = Array.new(4, '')
    @codes = %w[red blue yellow green white black]
    @board_count = 0
  end

  def print_board
    puts "#{@board[0].join(' | ')}"
    puts "#{@board[1].join(' | ')}"
    puts "#{@board[2].join(' | ')}"
    puts "#{@board[3].join(' | ')}"
    puts "#{@board[4].join(' | ')}"
    puts "#{@board[5].join(' | ')}"
    puts "#{@board[6].join(' | ')}"
    puts "#{@board[7].join(' | ')}"
    puts "#{@board[8].join(' | ')}"
    puts "#{@board[9].join(' | ')}"
    puts "#{@board[10].join(' | ')}"
    puts "#{@board[11].join(' | ')}"
  end

  def start_game
    puts 'Welcome to Mastermind! Choose whether you want to be the code-breaker or code-maker:'
    decide_player = gets.chomp
    return unless decide_player == 'code-breaker' || decide_player == 'code-maker'

    if decide_player == 'code-breaker'

      puts "Ok, let's go! Computer will generate a secret code of 4 colours from #{@codes}"
      print 'Computer is thinking'
      9.times do |i|
        sleep(1)
        print '.'
      end
      pick_secret_code
    elsif decide_player == 'code-maker'
      puts "Ok, you will make the secret code! Pick 4 colours from #{@codes} spearated by a space"
      
    end
  end

  # picks 4 random colours into @secret_code
  # allows for duplicate colors as per the rules!
  def pick_secret_code
    @secret_code.length.times do |i|
      @secret_code[i] = @codes.sample
    end
    puts 'Ready!'
    choice
  end

  def choice
    print_board
        
    puts "Correct Places: #{@right_places}"

    puts "Correct Colours: #{@right_colours}"

    puts "Choose 4 colours for #{@codes}, separating each with a space"
    @colour_picks = gets.chomp
    @colour_picks = @colour_picks.split(' ')

    if @colour_picks.length != 4
      puts 'The code must be exactly 4 colours!'
      choice
    end

    @colour_picks.each do |i|
      unless @codes.any?(i.downcase)
        puts 'One or more colours are incorrect'
        choice
      end
    end

    if win
      puts 'yay you win'
    else
      next_move unless @board_count == 12
    end

    "You lose! The secret code was #{@secret_code}"

    def next_move
  end
    
  
    @right_places = 0
    @right_colours = 0
    
    4.times do |i|
      if @colour_picks[i] == @secret_code[i]
        @right_places += 1
       
      elsif @secret_code.any?(@colour_picks[i])
        @right_colours += 1
      end
    end

    assign_colours
  
  end


  def assign_colours
    @board[@board_count] = @colour_picks
    @board_count += 1
    choice
  end

  def win
    @secret_code == @colour_picks
  end
end

mastermind_play = Mastermind.new
mastermind_play.start_game