  puts "============================="
  puts "Welcome to Terminal Blackjack"
 
  stack_of_cards = [
   "2 D", "3 D", "4 D", "5 D", "6 D", "7 D", "8 D", "9 D", "10 D", "J D", "Q D", "K D", "A D",
   "2 H", "3 H", "4 H", "5 H", "6 H", "7 H", "8 H", "9 H", "10 H", "J H", "Q H", "K H", "A H",
   "2 C", "3 C", "4 C", "5 C", "6 C", "7 C", "8 C", "9 C", "10 C", "J C", "Q C", "K C", "A C",
   "2 S", "3 S", "4 S", "5 S", "6 S", "7 S", "8 S", "9 S", "10 S", "J S", "Q S", "K S", "A S"
  ]
   stack_of_cards = stack_of_cards.shuffle
 
  @dealers_hand = []
  @players_hand =[]
 
  @players_hand << stack_of_cards.pop
  @dealers_hand << stack_of_cards.pop
 
  puts "dealer is showing a " + @dealers_hand.to_s
 
  @players_hand << stack_of_cards.pop
  @dealers_hand << stack_of_cards.pop
  puts "-------------------------"

  @dealer_aces = 0
  @dealers_hand_value = []
  
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

  dealer_filter
  get_value_dealer
  dealer_hand_total
 
  player_filter
  get_value_player
  player_hand_total

### testing area

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





#  if dealers_hand_value_num_actual == 21
#    puts "dealer has blackjack"
#    abort
#  end
#
#  puts "What would you like to do now?"
#  puts "'H' for Hit || 'S' for Stand"
#  puts "you have " + players_hand.to_s
#  puts " or " + players_hand_value_num_actual.to_s
#  stance_response = gets.chomp.upcase
#  
#  @clearing_house_num = []
#  @stack_of_cards = stack_of_cards
# 
# 
# if stance_response == "H"
#    take_a_hit_player
#  end
#
#  puts "you now have a total of " + players_hand_value_num_actual.to_s






