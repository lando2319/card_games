### Terminal War


  @stack_of_cards = [
  "2 D", "3 D", "4 D", "5 D", "6 D", "7 D", "8 D", "9 D", "10 D", "J D", "Q D", "K D", "A D",
  "2 H", "3 H", "4 H", "5 H", "6 H", "7 H", "8 H", "9 H", "10 H", "J H", "Q H", "K H", "A H",
  "2 C", "3 C", "4 C", "5 C", "6 C", "7 C", "8 C", "9 C", "10 C", "J C", "Q C", "K C", "A C",
  "2 S", "3 S", "4 S", "5 S", "6 S", "7 S", "8 S", "9 S", "10 S", "J S", "Q S", "K S", "A S"
  ]

  @stack_of_cards = @stack_of_cards.shuffle

  @dealers_hand = []
  @players_hand =[]

  def deal_cards
    until @stack_of_cards.count == 0 
      @dealers_hand << @stack_of_cards.pop
      @players_hand << @stack_of_cards.pop
    end
  end

  deal_cards

  @dealer_clearing_house = []
  @player_clearing_house = []

  @players_hand_value = []

  def cards_left
    if @dealers_hand.count < 4 
      puts "you win the game"
      abort
    elsif @players_hand.count < 4
      puts "you lose the game"
      abort
    end
  end

  def player_filter
    cards_left
    @player_clearing_house = @players_hand.first
      if @player_clearing_house.match("10")
        @players_hand_value << "10"
      elsif @player_clearing_house.match("J")
        @players_hand_value << "11"
      elsif @player_clearing_house.match("Q")
        @players_hand_value << "12"
      elsif @player_clearing_house.match("K")
        @players_hand_value << "13"
      elsif @player_clearing_house.match("A")
        @players_hand_value << "14"
      else
        @players_hand_value << @player_clearing_house
      end
  end

  @dealers_hand_value = []

  def dealer_filter
    cards_left
    @dealer_clearing_house = @dealers_hand.first
    if @dealer_clearing_house.match("10")
      @dealers_hand_value << "10"
    elsif @dealer_clearing_house.match("J")
      @dealers_hand_value << "11"
    elsif @dealer_clearing_house.match("Q")
      @dealers_hand_value << "12"
    elsif @dealer_clearing_house.match("K")
      @dealers_hand_value << "13"
    elsif @dealer_clearing_house.match("A")
      @dealers_hand_value << "14"
    else
      @dealers_hand_value << @dealer_clearing_house
    end
  end

  def dealer_second_card_eval
    cards_left
    @dealer_clearing_house = @dealers_hand.slice(1)
      if @dealer_clearing_house.match("10")
        @dealers_hand_value << "10"
      elsif @dealer_clearing_house.match("J")
        @dealers_hand_value << "11"
      elsif @dealer_clearing_house.match("Q")
        @dealers_hand_value << "12"
      elsif @dealer_clearing_house.match("K")
        @dealers_hand_value << "13"
      elsif @dealer_clearing_house.match("A")
        @dealers_hand_value << "14"
      else
        @dealers_hand_value << @dealer_clearing_house
      end
  end

  def player_second_card_eval
    cards_left
    @player_clearing_house = @players_hand.slice(1)
      if @player_clearing_house.match("10")
        @players_hand_value << "10"
      elsif @player_clearing_house.match("J")
        @players_hand_value << "11"
      elsif @player_clearing_house.match("Q")
        @players_hand_value << "12"
      elsif @player_clearing_house.match("K")
        @players_hand_value << "13"
      elsif @player_clearing_house.match("A")
        @players_hand_value << "14"
      else
        @players_hand_value << @player_clearing_house
      end
  end

  @clearinghouse_helper = []

  def this_means_war
    cards_left
    player_second_card_eval
    dealer_second_card_eval
    puts @dealers_hand_value.inspect
    puts "vs"
    puts @players_hand_value.inspect
    if @dealers_hand_value.first.to_i > @players_hand_value.first.to_i
      @clearinghouse_helper << @players_hand.slice!(0)
      @clearinghouse_helper << @players_hand.slice!(0)
      @clearinghouse_helper << @dealers_hand.slice!(0)
      @clearinghouse_helper << @dealers_hand.slice!(0)
      puts "dealer wins war"
      @clearinghouse_helper.each do |t|
        @dealers_hand << t
      end
      @clearinghouse_helper = []
      @dealers_hand_value = []
      @players_hand_value = []
    elsif @dealers_hand_value.first.to_i < @players_hand_value.first.to_i
      @clearinghouse_helper << @dealers_hand.slice!(0)
      @clearinghouse_helper << @dealers_hand.slice!(0)
      @clearinghouse_helper << @players_hand.slice!(0)
      @clearinghouse_helper << @players_hand.slice!(0)
      puts "player wins war"
      @clearinghouse_helper.each do |t|
        @players_hand << t
      end
      @clearinghouse_helper = []
      @dealers_hand_value = []
      @players_hand_value = []
    else
      @clearinghouse_helper << @dealers_hand.slice!(0)
      @clearinghouse_helper << @dealers_hand.slice!(0)
      @clearinghouse_helper << @players_hand.slice!(0)
      @clearinghouse_helper << @players_hand.slice!(0)
      @dealers_hand_value = []
      @players_hand_value = []
      puts "THE WAR CONTINUES"
      this_means_war
    end
  end

  def play_the_game
  cards_left
  player_filter
  dealer_filter
    puts @dealers_hand_value.inspect
    puts "vs"
    puts @players_hand_value.inspect
    if @dealers_hand_value.first.to_i > @players_hand_value.first.to_i
      @dealers_hand << @players_hand.slice!(0)
      @dealers_hand << @dealers_hand.slice!(0)
      puts "dealer wins"
      @dealers_hand_value = []
      @players_hand_value = []
    elsif @dealers_hand_value.first.to_i < @players_hand_value.first.to_i
      puts "player wins"
      @players_hand << @dealers_hand.slice!(0)
      @players_hand << @players_hand.slice!(0)
      @dealers_hand_value = []
      @players_hand_value = []
    else
      puts "tie, we are going to war"
      @dealers_hand_value = []
      @players_hand_value = []
      this_means_war
    end
  end

  until @players_hand.count < 4 || @dealers_hand.count < 4
    play_the_game
  end

  cards_left

#  puts @dealers_hand.count
#  puts @players_hand.count
#
#
#  puts @dealers_hand.inspect
#  puts @players_hand.inspect



