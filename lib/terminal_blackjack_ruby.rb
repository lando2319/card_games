  puts "============================="
  puts "Welcome to Terminal Blackjack"
 
  @stack_of_cards = [
   "2 D", "3 D", "4 D", "5 D", "6 D", "7 D", "8 D", "9 D", "10 D", "J D", "Q D", "K D", "A D",
   "2 H", "3 H", "4 H", "5 H", "6 H", "7 H", "8 H", "9 H", "10 H", "J H", "Q H", "K H", "A H",
   "2 C", "3 C", "4 C", "5 C", "6 C", "7 C", "8 C", "9 C", "10 C", "J C", "Q C", "K C", "A C",
   "2 S", "3 S", "4 S", "5 S", "6 S", "7 S", "8 S", "9 S", "10 S", "J S", "Q S", "K S", "A S"
  ]
   @stack_of_cards = @stack_of_cards.shuffle
 
  @dealers_hand = []
  @players_hand =[]
 
  @players_hand << @stack_of_cards.pop
  @dealers_hand << @stack_of_cards.pop
 
  puts "dealer is showing a " + @dealers_hand.to_s
 
  @players_hand << @stack_of_cards.pop
  @dealers_hand << @stack_of_cards.pop
  puts "-------------------------"

  @dealer_aces = 0
  @dealers_hand_value = []
  
  #@dealers_hand = ["A S", "K C"]

  def dealer_filter
    @dealers_hand.each do |t|
      if t.match("10")
        @dealers_hand_value << "10"
      elsif t.match("J")
        @dealers_hand_value << "10"
      elsif t.match("Q")
        @dealers_hand_value << "10"
      elsif t.match("K")
        @dealers_hand_value << "10"
      elsif t.match("A")
        @dealers_hand_value << "11"
        @dealer_aces = @dealer_aces + 1
      else
        @dealers_hand_value << t
      end
     end
  end


  @dealers_hand_value_num = [] 

  def get_value_dealer
    @dealers_hand_value.each do |t|
      @dealers_hand_value_num << t.to_i
    end
  end

  @accumulative_dealer_total = []

  def dealer_hand_total
    @accumulative_dealer_total = @dealers_hand_value_num.inject(:+)
  end




  #PLAYERS LOGIC

  @player_aces = 0
  @players_hand_value = []

  @players_hand = ["A S", "4 D"]

  def player_filter
    @players_hand.each do |t|
      if t.match("10")
        @players_hand_value << "10"
      elsif t.match("J")
        @players_hand_value << "10"
      elsif t.match("Q")
        @players_hand_value << "10"
      elsif t.match("K")
        @players_hand_value << "10"
      elsif t.match("A")
        @players_hand_value << "11"
        @player_aces = @player_aces + 1
      else
        @players_hand_value << t
      end
    end
  end


  @players_hand_value_num = [] 

  def get_value_player
   @players_hand_value.each do |t|
     @players_hand_value_num << t.to_i
   end
  end

  @accumulative_player_total = []

  def player_hand_total
    @accumulative_player_total = @players_hand_value_num.inject(:+)
  end

### Game Logic

  def initial_evaluation
   if @accumulative_dealer_total.to_i == 21 && @accumulative_player_total.to_i != 21
     puts @dealers_hand
     puts "dealer has blackjack"
     puts "you have " + @accumulative_player_total.to_s
     abort
   elsif @accumulative_dealer_total.to_i == 21 && @accumulative_player_total.to_i == 21
     puts "PUSH both player and dealer have Blackjack"
     abort
   elsif @accumulative_dealer_total.to_i != 21 && @accumulative_player_total.to_i == 21
     puts "You have a Blackjack"
     puts @players_hand
     abort
   else
   end
  end

  dealer_filter
  get_value_dealer
  dealer_hand_total
 
  player_filter
  get_value_player
  player_hand_total

  initial_evaluation

  ### play the game

  def flip_cards
    if @accumulative_dealer_total.to_i > 21
      puts @dealers_hand.to_s + "You win the dealer has busted"
    elsif @accumulative_dealer_total.to_i > @accumulative_player_total.to_i 
      puts @dealers_hand.to_s + "dealer wins with " + @accumulative_dealer_total.to_s
    elsif @accumulative_dealer_total.to_i < @accumulative_player_total.to_i
      puts @players_hand.to_s + "You win with " + @accumulative_player_total.to_s
      puts "Dealer had " + @dealers_hand.to_s
    else
      puts "Dealer has " + @dealers_hand.to_s + "and you have " + @players_hand.to_s
      puts "You have a push"
    end
  end

  def evaluate_game
    if @accumulative_player_total > 21
      abort
    elsif @accumulative_dealer_total.to_i < 17
      take_a_hit_dealer
    else
    end
  end

  def take_a_hit_dealer
     @dealers_hand << @stack_of_cards.pop
     @dealers_hand_value = []
     dealer_filter
     @dealers_hand_value_num = []

     get_value_dealer
     dealer_hand_total
     evaluate_game
  end
  
  def take_a_hit_player
      @players_hand << @stack_of_cards.pop
      puts "your card is " + @players_hand.last
      @players_hand_value = []
      player_filter
      @players_hand_value_num = []

      get_value_player
      player_hand_total

      if @accumulative_player_total > 21 && @player_aces == 0
        puts "you have busted with " + @accumulative_player_total.to_s 
        abort
      elsif @accumulative_player_total > 21 && @player_aces > 0
        @player_aces = @player_aces - 1
        @accumulative_player_total = @accumulative_player_total.to_i - 10
        if @accumulative_player_total > 21
          puts "you have busted with " + @accumulative_player_total.to_s
          abort
        elsif @accumulative_player_total == 21
          evaluate_game
        else
          player_decision
        end
      elsif @accumulative_player_total < 21
        player_decision
      else
        evaluate_game
      end
  end

  def player_decision
   puts "What would you like to do now?"
   puts "'H' for Hit || 'S' for Stand"
   puts "you have " + @players_hand.to_s
   puts " or " + @accumulative_player_total.to_s
   stance_response = gets.chomp.upcase
   if stance_response == "H"
     take_a_hit_player
   else
    evaluate_game
   end
  end


  player_decision
  flip_cards

  ### testing area

  puts "TESTING AREA"
  puts "dealers hand"
  puts @dealers_hand
  puts @dealers_hand_value.inspect
  puts @dealers_hand_value_num.inspect
  puts @accumulative_dealer_total.inspect
  
  puts '---------'
  puts "players hand"
  puts @players_hand
  puts @players_hand_value.inspect
  puts @players_hand_value_num.inspect
  puts @accumulative_player_total.inspect

  puts "aces"
  puts @dealer_aces
  puts @player_aces








