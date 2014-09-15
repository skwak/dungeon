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

  def drinks(power)
    @drinks << Caffeine.new(power)
    @drinks = []
  end

  def add_drinks(power)
    if power<10
      puts "Your CAFFEINATED CODING STRENGTH is at LEVEL #{power}."
    else
      puts "Your CAFFEINATED CODING STRENGTH is at LEVEL #{power}."
      puts "You are the best coder of all of humankind! (or at least best
      would be coder of all humankind). YOU WIN."
      abort ("*America Online Voice* Goodbye!")
    end
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
            abort("*America Online Voice* Goodbye!")
        else
            "Hm, sorry, I didn't understand. I am still learning to code."
        end
    elsif @player.location == :apt
      puts "You see a little dragon sitting in the corner of the room, crying and shivering, looking all alone."
      puts "He is wearing a name tag. The little dragon's name is Slime!...(press enter to continue)"
      my_dragon = Dragon.new("Slime")
      puts "He looks at you shyly."
      puts "Do you want to...
            1. Feed dragon (press '1')
            2. Toss dragon (press '2')
            3. Walk dragon (press '3')
            4. Rock dragon (press '4')
            5. Put dragon to bed? (press '5')
            ?????????????????????????????????"
      what_to_do = gets.chomp
      if what_to_do == "1"
        my_dragon.feed
      elsif what_to_do == "2"
        my_dragon.toss
      elsif what_to_do == "3"
        my_dragon.walk
      elsif what_to_do == "4"
        my_dragon.rock
      elsif what_to_do == "5"
        my_dragon.put_to_bed
      end
    elsif @player.location == :cafe
      add_drinks(4)
    elsif @player.location == :club
      add_drinks(6)
    elsif @player.location == :largecave
      add_drinks(100)
    end
  end

  class Player
    attr_accessor :name, :location, :power

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

  class Caffeine
    attr_accessor :player, :name, :location

    def initialize(power)
      @power = power
    end
  end

  class Dragon

    def initialize(name)
      @name = name
      @asleep = false
      @stuff_in_belly = 10
      @stuff_in_intestine = 0
      @name = gets.chomp
    end

    def feed
      puts "You feed Slime."
      @stuff_in_belly = 10
      passage_of_time
    end

    def walk
      puts "You walk Slime."
      @stuff_in_intestine = 0
      passage_of_time
    end

    def put_to_bed
      puts "You put Slime to bed."
      @asleep = true
      3.times do
        if @asleep
          passage_of_time
        end
        if @asleep
          puts "Slime snores, filling the room with smoke."
        end
      end
      if @asleep
        @asleep = false
        puts "Slime wakes up slowly."
      end
    end

    def toss
      puts "You toss Slime up into the air."
      puts "He giggles, which singes your eyebrows."
      passage_of_time
    end

    def rock
      puts "You rock Slime gently."
      @asleep = true
      puts "He briefly dozes off..."
      passage_of_time
      if @asleep
        @asleep = false
        puts "...but wakes when you stop."
      end
    end

  private

    def hungry?
      @stuff_in_belly <=2
    end

    def poopy?
      @stuff_in_intestine >=8
    end

    def passage_of_time
      if @stuff_in_belly >0
        @stuff_in_belly = @stuff_in_belly - 1
        @stuff_in_intestine = @stuff_in_intestine + 1
      else
        if @asleep
          @asleep = false
          puts "He wakes up suddenly!"
        end
        puts "Slime is starving! In desperation, he ate YOU!"
        exit
      end
      if @stuff_in_intestine >= 10
        @stuff_in_intestine = 0
        puts "Whoops! Slime} has an accident..."
      end

      if hungry?
        if @asleep
          @asleep = false
          puts "He wakes up suddenly!"
        end
        puts "Slime's stomach grumbles..."
      end

      if poopy?
        if @asleep
          @asleep = false
          puts "He wakes up suddenly!"
        end
        puts "Slime does the potty dance..."
      end
    end

  end

# Create the main dungeon object
my_dungeon = Dungeon.new("Ada Code Dungeon")

#Add rooms to the dungeon
#STREAM OF CONSCIOUSNESS
my_dungeon.add_room(:largecave, "LARGE CAVE",
"a large cavernous cave. You find a mini-fridge in the corner packed with Monster
Energy. You chug, chug, chug that MONSTER ENERGY.", {:west => :ada, :south =>
:cave, :north => :matrix, :east => :matrix})
my_dungeon.add_room(:smallcave, "SMALL CAVE",
"a small claustrophobic cave.",
{:east => :ada, :south=> :club, :north => :matrix, :west => :matrix})
my_dungeon.add_room(:club, "FLANNEL CLUB",
"a room full of men wearing flannel (and also plaid shirts they thought were
flannel shirts but are not) and nodding their heads to some band. This place is
weird. However, one guy in a plaid (totally not flannel) shirt offers you a flask
filled with espresso martini liquid. This guy is totally weird, but you chug the
espresso martini thing.",
{:north => :smallcave, :east => :apt, :south => :matrix, :west => :matrix})
my_dungeon.add_room(:beer, "BEER HALL",
"a beer hall full of people in lederhosen, draining pitchers of beer in single
gulps. You drink a pitcher and promptly fall asleep.", {:west => :hammock,
:south => :largecave, :east => :matrix, :north => :matrix})
my_dungeon.add_room(:ada, "ADA DEVELOPERS ACADEMY",
"a classroom full of budding programmers, their brains in various stages of
explosion.", {:south => :apt, :west => :smallcave, :east => :largecave,
:north => :hammock})
my_dungeon.add_room(:hammock, "SECRET HAMMOCK",
"a hammock which you hop onto and promptly doze off. Zzzzzz. Oops.", {:west =>
:food, :south=> :ada, :east => :matrix, :north => :matrix})
my_dungeon.add_room(:apt, "YOUR APARTMENT",
"a small, studio apartment. You see
your two cats; they brush up against your legs. You head towards the kitchen,
where your French Press resides.", {:north=> :ada, :west => :club, :east =>
:cafe, :south => :matrix})
my_dungeon.add_room(:cafe, "JAVA CAFE",
"a shiny cafe, where programmers sit drinking expensive coffee and code in Java.
You don't know Java. Even though this place has coffee, this place is so not
relevant to you right now.", {:west => :apt, :north => :largecave, :east =>
:matrix, :south => :matrix})
my_dungeon.add_room(:food, "UMMA'S LUNCHBOX",
"a Korean restaurant. You bury your face in a box of steaming vegetables, hoping
that eating will bring you some joy in this sick, sad world.", {:south =>
:smallcave, :east => :hammock, :north=>:matrix, :west => :matrix})
my_dungeon.add_room(:matrix, "UNKNOWN",
"a shapeshifting room that is all black, with green numbers and letters falling
like rain upon your hunched shoulders. I have no idea. It's like The Matrix. Full
of plotholes (oh, snap).", {:south => :food, :east => :food, :east => :smallcave,
:east => :club, :south => :hammock, :south => :beer, :west => :beer, :west =>
:largecave, :west => :cafe,  :north => :cafe, :north => :apt, :north => :club })



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
    abort("*America Online Voice* Goodbye!")
  end
end


end
