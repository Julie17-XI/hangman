class Hangman
  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word=Hangman.random_word
    length=@secret_word.length
    @guess_word=[]
    length.times {@guess_word<<'_'}
    @attempted_chars=[]
    @remaining_incorrect_guesses=5
  end

  def already_attempted?(char)
    if @attempted_chars.include?(char)
      true
    else
      false
    end
  end

  def get_matching_indices(char)
    idx_arr=[]
    @secret_word.each_char.with_index do |ele,i|
      if ele==char
        idx_arr<<i
      end
    end
    idx_arr
  end

  def fill_indices(char,idx_arr)
    @guess_word.each_with_index do |ele,i|
      if idx_arr.include?(i)
        @guess_word[i]=char
      end
    end
  end

  def try_guess(char)
    if !self.already_attempted?(char)
      @attempted_chars << char
      if self.get_matching_indices(char).empty?
        @remaining_incorrect_guesses-=1
      else
        idx_arr=self.get_matching_indices(char)
        self.fill_indices(char,idx_arr)
      end
      true
    else
      puts "that has already been attempted."
      false
    end
  end

  def ask_user_for_guess
    puts "Enter a char:"
    self.try_guess(gets.chomp)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "WIN"
      true
    else
      false
    end    
  end

  def lose?
    if @remaining_incorrect_guesses==0
      puts "LOSE"
      true
    else
      false
    end    
  end

  def game_over?
    if self.win?||self.lose?
      puts @secret_word
      true
    else
      false
    end
  end
end

