class Dungeon
  attr_accessor :player

  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms = []
  end

  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end

  def start(location)
    @player.location = location
    show_current_description
  end

  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_dungeon(reference)
    @rooms.detect{|room| room.reference == reference}
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
  end

  def go(direction)
    puts "You go " + direction.to_s
    @player.location = find_room_in_direction(direction)
    show_current_description
    if @player.location == :hammock || @player.location == :beer
      puts "\nSo, I hate to tell you this, but since you fell asleep, you have LOST."

      puts "If it makes you feel better, though, you are SLEEPING, so you aren't even aware that you've lost."

      puts "  *If you want to start over, type 'start'."

      puts "  *If you want to exit completely, type 'exit':"

      almost_over = gets.chomp
        if almost_over == "start"
            start(:ada)
        elsif almost_over == "exit"
            abort("*American Online Voice* Goodbye!")
        else
            "Hm, sorry, I didn't understand. I am still learning to code."
        end
    # elsif @player.location == :apt
    #   drink("coffee")
    #   puts "woooh"
    end
  end

  class Player
    attr_accessor :name, :location

    def initialize(name)
      @name = name
    end


  end

  class Room
    attr_accessor :reference, :name, :description, :connections

    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end

    def full_description
      @name + "\n\nYou are in " + @description
    end

  end



# class Caffeine
#   def initialize(type, power)
#     @type = type
#     @power = power
#   end
#
#   def drink(type)
#     power += 1
#     puts "You drink #{type}."
#     if power <=10
#       puts "Your power is now at Grade #{power}."
#     elsif power >10
#       puts "You are the best coder of all of humankind! (or at least best
#       would be coder of all humankind). YOU WIN."
#
#     end
#   end

end



# Create the main dungeon object
my_dungeon = Dungeon.new("Ada Code Dungeon")

#Add rooms to the dungeon
my_dungeon.add_room(:largecave, "LARGE CAVE", "a large cavernous cave.",
{:west => :ada, :south => :cave, :north => :matrix, :east => :matrix})
my_dungeon.add_room(:smallcave, "SMALL CAVE", "a small claustrophobic cave.",
{:east => :ada, :south=> :club, :north => :matrix, :west => :matrix})
my_dungeon.add_room(:club, "FLANNEL CLUB", "a room full of men wearing flannel
(and also plaid shirts they thought were flannel shirts but are not) and nodding
their heads to some band. This place is weird. However, one guy in a plaid
(totally not flannel) shirt offers you a flask filled with espresso martini liquid.
This guy is totally weird, but you chug the espresso martini thing.",{:north => :smallcave, :east =>
:apt, :south => :matrix, :west => :matrix})
my_dungeon.add_room(:beer, "BEER HALL", "a beer hall full of people in
lederhosen, draining pitchers of beer in single gulps. You drink a pitcher and
promptly fall asleep.", {:west => :hammock, :south => :largecave, :east =>
:matrix, :north => :matrix})
my_dungeon.add_room(:ada, "ADA DEVELOPERS ACADEMY", "a classroom full of budding
programmers, their brains in various stages of explosion.", {:south => :apt,
:west => :smallcave, :east => :largecave, :north => :hammock})
my_dungeon.add_room(:hammock, "SECRET HAMMOCK", "a hammock which you hop onto
and promptly doze off. Zzzzzz. Oops.", {:west => :food, :south=> :ada, :east =>
:matrix, :north => :matrix})
my_dungeon.add_room(:apt, "YOUR APARTMENT", "a small, studio apartment. You see
your two cats; they brush up against your legs. You head towards the kitchen,
where your French Press resides.", {:north=> :ada, :west => :club, :east =>
:cafe, :south => :matrix})
my_dungeon.add_room(:cafe, "JAVA CAFE", "a shiny cafe, where programmers sit
drinking expensive coffee and code in Java. You don't know Java. Even though this
place has coffee, this place is so not relevant to you right now.", {:west =>
:apt, :north => :largecave, :east => :matrix, :south => :matrix})
my_dungeon.add_room(:food, "UMMA'S LUNCHBOX", "a Korean restaurant. You bury
your face in a box of steaming vegetables, hoping that eating will bring you
some joy in this sick, sad world.", {:south => :smallcave, :east => :hammock,
:north=>:matrix, :west => :matrix})
my_dungeon.add_room(:matrix, "UNKNOWN", "a shapeshifting room that is all black,
with green numbers and letters falling like rain upon your hunched shoulders.
I have no idea. It's like The Matrix. Full of plotholes (oh, snap).", {:south =>
:food, :east => :food, :east => :smallcave, :east => :club, :south => :hammock,
:south => :beer, :west => :beer, :west => :largecave, :west => :cafe,
  :north => :cafe, :north => :apt, :north => :club })

#Start the dungeon

puts "Welcome to the ADA CODE DUNGEON.\n

************************************************************************************
************************************************************************************
************************************************************************************
                        'They                                          'W
    \\\\      \\\\       \\\\   call                                         u
   //\\\\    ||\\\\     //\\\\      it                                         t
  //==\\\\   || \\\\   //==\\\\       a MENTAL                                ?'
 //    \\\\  || //  //    \\\\        BREAKDOWN' -John Maus                 -Le1f
***********||//********************>>>> code or sleep code or sleep code or sleep???
************//*CODE DUNGEON********>>>> code or sleep code or sleep code or sleep???
************************************************************************************
************************************************************************************

How wonderful to see you, coder! \n

Even though your brain is zapped, your shoulders are hunched, and your desire
for sleep is mounting, you must stay awake, remain motivated, and keep truckin'
for Ruby or whoever you want to fight for. And for the money, power, and glory,
if you care about those things. \n

So...what's your name?"
name = gets.chomp

puts "Ah, #{name}. You are in for a real battle (if I can get this thing to
actually work). \n

You start off at:"


my_dungeon.start(:ada)

while true
  puts "Where do you want to go?
  * North (type 'north')
  * West (type 'west')
  * East (type 'east')
  * South (type 'south')
  * BACK TO START (type 'start')
  * EXIT THIS FORSAKEN GAME (type 'exit')"
  move = gets.chomp

  if move == "north"
    my_dungeon.go(move.to_sym)
  elsif move == "west"
    my_dungeon.go(move.to_sym)
  elsif move == "east"
    my_dungeon.go(move.to_sym)
  elsif move == "south"
    my_dungeon.go(move.to_sym)
  elsif move =="start"
    my_dungeon.start(:ada)
  elsif move =="exit"
    abort("*American Online Voice* Goodbye!")
  else
    puts "Hm, sorry, I didn't understand. I am still learning to code."
  end



end
