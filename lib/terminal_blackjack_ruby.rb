### Terminal Blackjack

  @stack_of_cards = [
  "2 D", "3 D", "4 D", "5 D", "6 D", "7 D", "8 D", "9 D", "10 D", "J D", "Q D", "K D", "A D",
  "2 H", "3 H", "4 H", "5 H", "6 H", "7 H", "8 H", "9 H", "10 H", "J H", "Q H", "K H", "A H",
  "2 C", "3 C", "4 C", "5 C", "6 C", "7 C", "8 C", "9 C", "10 C", "J C", "Q C", "K C", "A C",
  "2 S", "3 S", "4 S", "5 S", "6 S", "7 S", "8 S", "9 S", "10 S", "J S", "Q S", "K S", "A S"
  ]

### For Testing Aces
#  @stack_of_cards = [
#  "A D", "A D", "A D", "A D",
#  "A H", "A H", "A H", "A H",
#  "A C", "A C", "A C", "A C",
#  "A S", "A S", "A S", "A S"
#  ]

  @stack_of_cards = @stack_of_cards.shuffle
  
  @dealers_hand = []
  @players_hand =[]
  
  puts "============================="
  puts "Welcome to Terminal Blackjack"  

  @dealers_hand_value = []
  @players_hand_value = []

  @dealer_aces = 0
  @player_aces = 0

  def dealer_filter
    @first_card = @dealers_hand.last
      if @first_card.match("10")
        @dealers_hand_value << "10"
      elsif @first_card.match("J")
        @dealers_hand_value << "10"
      elsif @first_card.match("Q")
        @dealers_hand_value << "10"
      elsif @first_card.match("K")
        @dealers_hand_value << "10"
      elsif @first_card.match("A")
        @dealers_hand_value << "11"
        @dealer_aces = @dealer_aces + 1
      else
        @dealers_hand_value << @first_card
      end
  end
  
  def player_filter
    @player_first_card = @players_hand.last
      if @player_first_card.match("10")
        @players_hand_value << "10"
      elsif @player_first_card.match("J")
        @players_hand_value << "10"
      elsif @player_first_card.match("Q")
        @players_hand_value << "10"
      elsif @player_first_card.match("K")
        @players_hand_value << "10"
      elsif @player_first_card.match("A")
        @players_hand_value << "11"
        @player_aces = @player_aces + 1
      else
        @players_hand_value << @player_first_card
      end
  end


  ### Calculate Hand

  @dealers_hand_value_num = [] 

  def get_value_dealer
      @dealers_hand_value_num << @dealers_hand_value.last.to_i
  end

  @accumulative_dealer_total = []

  def dealer_hand_total
    @accumulative_dealer_total = @dealers_hand_value_num.inject(:+)
  end

  def aces_evaluation_dealer
    if @accumulative_dealer_total.to_i > 21 && @dealer_aces > 0
      @dealer_aces = @dealer_aces - 1
      @accumulative_dealer_total = @accumulative_dealer_total - 10
      @dealers_hand_value_num << -10
    end
  end
  

  @players_hand_value_num = [] 

  def get_value_player
     @players_hand_value_num << @players_hand_value.last.to_i
  end

  @accumulative_player_total = []

  def player_hand_total
    @accumulative_player_total = @players_hand_value_num.inject(:+)
  end

  def aces_evaluation_player
    if @accumulative_player_total.to_i > 21 && @player_aces > 0
      @player_aces = @player_aces - 1
      @accumulative_player_total = @accumulative_player_total - 10
      @players_hand_value_num << -10
    end
  end

### First Card

  @players_hand << @stack_of_cards.pop
  @dealers_hand << @stack_of_cards.pop
 
  puts "dealer is showing a " + @dealers_hand.to_s
 
  dealer_filter
  player_filter
  
  get_value_dealer
  dealer_hand_total
  aces_evaluation_dealer

  get_value_player
  player_hand_total
  aces_evaluation_player

### Second Card

  @players_hand << @stack_of_cards.pop
  @dealers_hand << @stack_of_cards.pop

  dealer_filter
  player_filter
  
  get_value_dealer
  dealer_hand_total
  aces_evaluation_dealer

  get_value_player
  player_hand_total
  aces_evaluation_player

### Dealer checks the whole card

  def initial_evaluation
    if @accumulative_dealer_total.to_i == 21 && @accumulative_player_total.to_i != 21
      puts @dealers_hand
      puts "dealer has blackjack"
      puts "you have " + @players_hand.to_s + " or " + @accumulative_player_total.to_s
      abort
    elsif @accumulative_dealer_total.to_i == 21 && @accumulative_player_total.to_i == 21
      puts "PUSH both player and dealer have Blackjack" + " you had " + @players_hand.to_s
      abort
    elsif @accumulative_dealer_total.to_i != 21 && @accumulative_player_total.to_i == 21
      puts "You have a Blackjack"
      puts @players_hand
      abort
    else
    end
  end

  initial_evaluation

### Moves for the Dealer

  def take_a_hit_dealer
    puts "Dealer has " + @dealers_hand.to_s + " Dealer is taking a hit ..."
    @dealers_hand << @stack_of_cards.pop
     dealer_filter

     get_value_dealer
     dealer_hand_total
     aces_evaluation_dealer
     evaluate_game
  end

### Evaluate Game

  def evaluate_game
    if @accumulative_dealer_total > 21
      puts "you have won. The dealer has busted with " + @dealers_hand.to_s + " or " + @accumulative_dealer_total.to_s
    elsif @accumulative_dealer_total < 17
      take_a_hit_dealer
    else
      if @accumulative_dealer_total.to_i > @accumulative_player_total.to_i
        puts "You Lost the Dealer has " + @dealers_hand.to_s + " or " + @accumulative_dealer_total.to_s + " and you had " + @accumulative_player_total.to_s
      elsif @accumulative_dealer_total.to_i < @accumulative_player_total.to_i
        puts "You Won the Dealer has " + @dealers_hand.to_s + " or " + @accumulative_dealer_total.to_s + " and you had " + @accumulative_player_total.to_s
      else @accumulative_dealer_total == @accumulative_player_total
        puts "You have a push. The dealer has " + @dealers_hand.to_s + " or " + @accumulative_dealer_total.to_s + " and you have " + @players_hand.to_s + " or " + @accumulative_player_total.to_s
      end
    end
  end

### Moves for the Player
  
  def over_20_player
    if @accumulative_player_total.to_i > 21
      puts "You have busted with " + @accumulative_player_total.to_s
      puts "The Dealer had a " + @dealers_hand.to_s
    elsif @accumulative_player_total.to_i == 21
      evaluate_game
    else 
      player_decision
    end
  end

  def take_a_hit_player
      @players_hand << @stack_of_cards.pop
      puts "your card is " + @players_hand.last
      player_filter
      get_value_player
      player_hand_total
      aces_evaluation_player
      over_20_player
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
  

  ### testing area

#  puts "TESTING AREA"
#  puts "dealers hand"
#  puts @dealers_hand
#  puts @dealers_hand_value.inspect
#  puts @dealers_hand_value_num.inspect
#  puts @accumulative_dealer_total.inspect
#  
#  puts '---------'
#  puts "players hand"
#  puts @players_hand
#  puts @players_hand_value.inspect
#  puts @players_hand_value_num.inspect
#  puts @accumulative_player_total.inspect
#
#  puts "aces"
#  puts @dealer_aces
#  puts @player_aces
