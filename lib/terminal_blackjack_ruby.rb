def blackjack
  puts "============================="
  puts "Welcome to Terminal Blackjack"
 
  stack_of_cards = [
   "2 D", "3 D", "4 D", "5 D", "6 D", "7 D", "8 D", "9 D", "10 D", "J D", "Q D", "K D", "A D",
   "2 H", "3 H", "4 H", "5 H", "6 H", "7 H", "8 H", "9 H", "10 H", "J H", "Q H", "K H", "A H",
   "2 C", "3 C", "4 C", "5 C", "6 C", "7 C", "8 C", "9 C", "10 C", "J C", "Q C", "K C", "A C",
   "2 S", "3 S", "4 S", "5 S", "6 S", "7 S", "8 S", "9 S", "10 S", "J S", "Q S", "K S", "A S"
  ]
   stack_of_cards = stack_of_cards.shuffle
 
  dealers_hand = []
  players_hand =[]
 
  players_hand << stack_of_cards.pop
  dealers_hand << stack_of_cards.pop
 
  puts "dealer is showing a " + dealers_hand.to_s
 
  players_hand << stack_of_cards.pop
  dealers_hand << stack_of_cards.pop
 
  puts "you have " + players_hand.to_s
 
  puts "-------------------------"
  puts "What would you like to do now?"
  puts "'H' for Hit || 'S' for Stand"

  puts dealers_hand

  dealers_hand_value = []
  
  dealers_hand.each do |t|
    if t.match("10")
      dealers_hand_value << "10"
    elsif t.match("J")
      dealers_hand_value << "10"
    elsif t.match("Q")
      dealers_hand_value << "10"
    elsif t.match("K")
      dealers_hand_value << "10"
    elsif t.match("A")
      dealers_hand_value << "10"
    else
      dealers_hand_value << t
  end
  end

  dealers_hand_value_num = [] 

  dealers_hand_value.each do |t|
    dealers_hand_value_num << t.to_i
  end

  puts dealers_hand_value_num
  
end













