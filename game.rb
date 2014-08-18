@credits = {"Creator" => "InvalidCookie",
	"Design, Narrative, and Misc help" => "Kitteh"}

def game_credit
	@credits.each {|title, person| puts "#{title} ~ #{person}"}
end

require 'etc'
@inventory = []

def prompt()
	print "Enter command > "
end

def inventory()
	puts 'Your inventory contains:'
	puts @inventory
end

def exit()
	Process.exit
end

def map_shack()
	puts " ==D== "
	puts "|    C|" 
	puts "|F T  |"
	puts "|  U L|"  
	puts " ===== "
	puts "legend:"
	puts "D - Door"
	puts "C - Clock"
	puts "F - Fireplace"
	puts "T - Table"
	puts "U - Trapdoor"
	puts "L - Pile of logs"
end

@wooden_box = "W"
@painting = "P"
@crowbar = "C"
@crowbar_text = "\nC - Crowbar"
@wooden_box_text = "\nW - Wooden box"
@painting_text = "\nP - Painting"

def map_cellar()  
	puts " ===%s=" % [@painting]
	puts "|X   B|"
	puts "T  S  |"
	puts "|%s L %s|" % [@crowbar, @wooden_box]
	puts " ===== "
	puts "legend:%s" % [@painting_cellar]
	#puts "P - Painting"
	puts "X - Pile of bones"
	puts "B - Barrel"
	puts "T - Tunnel"
	puts "S - Support beam%s" % [@crowbar_text]
	#puts "C - Crowbar"
	puts "L - Ladder%s" % [@wooden_box_text]
	#puts "W - Wooden box"
end

@painting_inspect = ""
@painting_description = "\nA [Painting] hangs in the far back corner%s," % [@painting_inspect]
@bones_inspect = ""
@barrel_inspect = ""
@tunnel_inspect = ""
@crowbar_inspect = ""
@crowbar_description = "\nA%s [Crowbar] is haphazardly thrown in the south-west corner" % [@crowbar_inspect]
@ladder_inspect = ""
@box_inspect = ""

@crowbar_taken = false
@web_taken = false
@rock_taken = false
@tool_made = false
@tape_aquired = false
@tape_used = false

def look_cellar()
	@crowbar_description = "\nA%s [Crowbar] is haphazardly thrown in the south-west corner" % [@crowbar_inspect]
	@painting_description = "\nA [Painting] hangs in the far back corner%s," % [@painting_inspect]
	puts "The cellar has a musty smell, Spider webs hang everywhere, Rocks litter the ground,%s" % [@painting_description]
	#puts "painting"
	puts "A pile of%s [Bones] lie in the back west corner alongside a%s [Barrel] in the opposite corner" % [@bone_inspect, @barrel_inspect]
	puts "Part of the west wall is crumbling and opening into a [Tunnel]%s" % [@tunnel_inspect]
	puts "A thick metal [Support beam] stands in the middle of the cellar%s" % [@crowbar_description]
	#puts "crowbar"
	puts "A%s [Ladder] which you desended into the cellar from" % [@ladder_inspect]
	puts "A%s [Wooden box] is in the south-east corner" % [@box_inspect]
end

def help()
	puts "Commands should be straight forward and simple (hopefully)"
	puts "If you get stuck try repeating actions you have used previously."
	puts "'Invalid Cookie' is a alias for 'Invalid Command'"
	puts "Inventory"
	puts "Map"
	puts "Exit"
	puts "~~"
	puts "Look"  #look at rooms,
	puts "Use"  #use item on item to get somewhere
	puts "Inspect"  #specific item/place
	puts "Take"  #take item
end

@door_leads = 'the unknown'  #when inspected =outside
@door_status = ''  #locked/unlocked
@fireplace_status = '' #burning/not  burning
@clock_status = ''  #broken/fixed
@clock_hands = "" 
@trapdoor_status = ''  #locked/unlocked  
@table_stuff = "" #screwdriver/no screwdriver

@screwdriver_taken = false
@table_inspect = true

@trapdoor_first == true
@trapdoor_unlocked = false
@fireburn = false

@clockattempt = 0

@key1 = false #fireplace key
@key2 = false #clock key
@key3 = false #wooden crate
@key4 = false #abyss
@key5 = false #painting/barrel

#add variables to the looks,
def look()
  puts "A%s [Door] lies north of you leading to %s," % [@door_status, @door_leads]
  puts "A%s [Fireplace] is along the west wall" % [@fireplace_status]
  puts "A [Table] is in the center of the room%s" % [@table_stuff] 
  puts "A%s grandfather styled [Clock]%s is in the north-east corner of the room" % [@clock_status, @clock_hands]
  puts "A%s [Trapdoor] is against the south wall" % [@trapdoor_status]
  puts "A pile of wooden logs is in the south-east corner of the room" #put logs in firepalce evry so often or bad things happen
end

def start
	while true
	puts ""
	prompt; next_move = gets.chomp.downcase
#basic commands
if next_move == "go cellar"
	cellar
end
	 	if next_move == "help"
 			help; start
		end
		if next_move == "inventory"
			inventory; start
		end
		if next_move == "map"
			map_shack; start
		end
		if next_move == "look"
			look; start
		end
		if next_move == "exit"
			exit
		end
		if next_move == "credit" or next_move == "credits"
			game_credit; start
		end
#inspect
		if next_move == "inspect door"
			puts "The door is locked,"
			@door_status = " locked"
			puts "You look through the small peakhole in the door,"; puts "It appears to lead into a forest"; puts "You cant see anything else"
			@door_leads = "a forest"; start
		end
		if next_move == "inspect clock"
			puts "Its a broken clock with the hands stuck on 12:00"
			@clock_status = " broken";@clock_hands = " with its hands on 12:00"; start
		end
		if next_move == "inspect fireplace"
			if @key1 == false and @fireburn == true
				puts "The log has burned to ashes, exposing a part of a key"
				puts "You take [Key part 1]"
				@key1 = true
				@inventory << "Key part 1"
				@fireburn = false
			elsif @fireburn == true
				puts "The log has burned to ashes"
				@fireburn = false
			else
				puts "The fireplace contains hot embers"
			end
		start
		end
		if next_move == "inspect trapdoor"
			puts "Its a locked trapdoor"
			@trapdoor_status = " locked"; start
		end
		if next_move == "inspect logs" 
			puts "A pile of logs"; start
		end
		if next_move == "inspect table"
			if @screwdriver_taken == false
				puts "The table has a [Screwdriver] on it."
				@table_inspect = true
				@table_stuff = " contains a crewdriver"
			else
				puts "The table is empty"
				@table_stuff = ""
			end
		start
		end
		if next_move == "inspect wall" or next_move == "inspect walls"
			puts "Your standard reinforced walls, your not getting out through there"; start
		end
		movecon = next_move.include? "insepct "
		if movecon == true
			puts "These is nothing to take not of"
			start
		end
#take
		if next_move == "take log" or next_move == "take logs"
			ininv = @inventory.include? "Log"
				if ininv == false
					@inventory << "Log"
					puts "You take a [Log]"
				else
					puts "You already have a log"
				end
			start
		end
		if next_move == "take screwdriver"
				if @screwdriver_taken == false and @table_inspect == true
					@inventory << "Screwdriver"
					puts "You take the [Screwdriver]"
					@screwdriver_taken = true
				elsif @table_inspect == false
					puts "What screwdriver?"
				else
					puts "You already have the [Screwdriver]"
				end
			start
			end
			movecon = next_move.include? "take "
			if movecon == true
				puts "You cannot take this"
				start
			end
#use
		if next_move == "use trapdoor"
			if @trapdoor_first == true and @trapdoor_unlocked == true
				puts "You open the trapdoor,"; puts "hinges creaking,"; puts "and descend into the abyss below"
				puts ""; puts "You climb down the ladder for what feels like ages..."
				@trapdoor_first == false
				cellar
			elsif @trapdoor_unlocked == true
				puts "You climb down the ladder for what feels like ages..."
				cellar
			else
				puts "The trapdoor is locked"
			end
		start
		end

		if next_move == "use screwdriver clock"# or next_move == "use broken screwdriver clock"
			ininv = @inventory.include? "Screwdriver"
				if ininv == true and @key2 == false
					puts "You hit the clock hands with the screwdriver,"; puts "the hands spin around,"; puts "the hands stop on the time 4:20 and [Key part 2] pops out."
					@key2 = true
					@inventory << "Key part 2"
					@clock_hands = " with its hands on 4:20"
					# @inventory.delete "Screwdriver"
					# @inventory << "Broken Screwdriver"
				elsif @key2 == true and @trapdoor_unlocked == false
					puts "You hit the clock again,"; puts "the hands spin around and all land on 6,"; puts "you get the feeling it doesnt mean 6:30."; puts "You hear a small click to the right of you."
					@trapdoor_unlocked = true
					@clock_hands = " with its hands displaying 6:66"
				elsif @trapdoor_unlocked == true
					puts "All the hands lie on 6,"; puts "you get a eerie feeling it doesnt mean 6:30."; puts "Its best not to mess with the clock anymore"
					# @clockattempt += 1
					# 	if @clockattempt == 3
					# 	puts ""
					# 	puts "Death would be a mercy"
					# 	sleep(1)
					# 	Process.exit
					# end
				else
					puts "You lack the delicate tool and precision to interact with this"
				end
			start
			end
		if next_move == "use log fireplace"
			loginv = @inventory.include? "Log"
				if loginv == true and @fireburn == false
					puts "You throw a log into the fireplace,"; puts "as if by magic the fire springs to life"
					@fireburn = true
					@inventory.delete "Log"
					@fireplace_status = " burning"
				elsif loginv == false
					puts "You dont have anything to throw into the fireplace"
				elsif @fireburn == true
					puts "There is already a fire going"
				end
			start
		end
		movecon = next_move.include? "use "
		if movecon == true
			puts "Nothing happens..."
			start
		else 
			puts "Invalid Cookie"
		end
	end
end

def cellar
	while true
	puts ""
	prompt; next_move = gets.chomp.downcase
#basic commands
	 	if next_move == "help"
 			help; cellar
		end
		if next_move == "inventory"
			inventory; cellar
		end
		if next_move == "map"
			map_cellar; cellar
		end
		if next_move == "look"
			look_cellar; cellar
		end
		if next_move == "exit"
			exit
		end
		if next_move == "credit" or next_move == "credits"
			game_credit; cellar
		end
#inspect -painting
		if next_move == "inspect tunnel"
			puts "You peak inside the tunnel,"; puts "it looks as if after a few feet the light is swallowed by darkness,"
			puts "after awhile it feels as if the darkness is looking back,"; puts "you back away from the tunnel and decide it isnt a good idea to go down it."
			cellar
		end
		if next_move == "inspect crowbar"
			if @crowbar_taken == false
				puts "Your basic metal crowbar"
				@crowbar_inspect = " metal"
			else
				puts "You already have the crowbar"
			end
		cellar
		end
		if next_move == "inspect bones" or next_move == "inspect bone"
			puts "Various bones with a strikingly human resemblence are strewn about the floor"
			@bone_inspect = " various human"
		cellar
		end
		if next_move == "inspect support beam" or next_move == "inspect supportbeam"
			puts "A thick rounded metal beam holding up the ceiling"; cellar
		end
		if next_move == "inspect wooden box"
			puts "A typical wooden box"; cellar
		end
		if next_move == "inspect ladder"
			puts "The wooden ladder you used to get down here"
			puts "Creaks a lot, like a lot lot."
			@ladder_inspect = " wooden"
			cellar
		end
		if next_move == "inspect barrel"
			puts "A reinforced wooden barrel with metal rings"
			@barrel_inspect = " reinforced"
			cellar
		end
		movecon = next_move.include? "insepct "
		if movecon == true
			puts "These is nothing to take not of"
			start
		end
#take
		if next_move == "take crowbar"
			if @crowbar_taken == false
				puts "You take the crowbar"
				@inventory << "Crowbar"
				@crowbar = " "; @crowbar_text = ""; @crowbar_inspect = ""; @crowbar_description = ""
				@crowbar_taken = true
			else
				puts "You already have the crowbar"
			end
		cellar
		end
		if next_move == "take bone" or next_move == "take bones"
			ininv = @inventory.include? "Bone"
				if ininv == false
					@inventory << "Bone"
					puts "You take a bone"
				else
					puts "You already have a bone"
				end
			cellar
		end
		if next_move == "take spider web"
				if @web_taken == false
					puts "You take the spider web"
					puts "But you dont know how it would be useful..."
					@inventory << "Spider web"
					@web_taken = true
				else
					puts "You already have enough spider web..."
				end
			cellar
		end
		if next_move == "take rock"
			if @rock_taken == false
				puts "You take the rock"
				puts "But you dont know how it would be useful..."
				@inventory << "Rock"
				@rock_taken = true
			else
				puts "You already have enough rocks..."
			end
		cellar
		end
		movecon = next_move.include? "take "
		if movecon == true
			puts "You cannot take this"
			start
		end
#use
		if next_move == "use crowbar wooden box"
			if @key3 == false
				puts "You smash the box with the crowbar,"
				puts "After sorting through the debri you find [Key part 3]"
				@inventory << "Key part 3"
				@key3 = true
				@box_inspect = " smashed"
			else
				puts "The box is already smashed"
			end
			cellar
		end
		if next_move == "use club barrel" or next_move == "use improvised club barrel" and @tool_made == true
			if @tape_aquired == false
				puts "You smash the barrel into pieces,"
				puts "In the middle of the wreckage you find a [Tape],"
				puts "The [Tape] gives you eerie feeling but you take it anyway"
				@inventory << "Tape"
				@tape_aquired = true
				cellar
			end
		end
		if next_move == "use tape"
			if @tape_used == false
				while true
				puts "Would you like to use the tape?"
				usetape = gets.chomp.downcase
					if usetape == "yes"
						tape
						@tape_used = true
						puts "You exist in a room"
						start
					end
				end
				if usetape == "no"
					puts "The tape is unnerving so you dont use it"
					cellar
				else
					puts "Invalid Cookie"
				end
			end
			cellar
		end
		if next_move == "use club wooden box" or next_move == "use improvised club wooden box" and @tool_made == true
			if @key3 == false
				puts "You smash the box with the club,"
				puts "After sorting through the debri you find [Key part 3]"
				@inventory << "Key part 3"
				@key3 = true
				@box_inspect = " smashed"
			else
				puts "The box is already smashed"
				cellar
			end
		end
		if next_move == "use bone tunnel"
			if @key4 == false
				puts "You throw a bone into the tunnel"
				puts "You hear a munching sounds"
				puts "After awhile the munching stops and an item gets tossed toward you"
				puts "You pickup [Key part 4]"
				@inventory << "Key part 4"
				@key4 = true
				@inventory.delete "Bone"
			else
				puts "You decide tempting fate once is enough"
			end
			cellar
		end
		if next_move.include? "use"
			if next_move.include? "rock" and @rock_taken == true
				if next_move.include? "spider web" and @web_taken == true
					if next_move.include? "log" and @inventory.include? "Log"
						if @tool_made == false
							puts "You combine the Rock, Log, and Spider web to make a improvised club"
							puts "You dont know how it would be useful..."
							@inventory.delete "Spider web"
							@inventory.delete "Log"
							@inventory.delete "Rock"
							@inventory << "Improvised club"
							@tool_made = true
						else
							"You already have the Improvised tool"
							cellar
						end
					end
				end
			end
		end
		if next_move == "use ladder"
			puts "You climb the ladder,"
			puts "Every step makes a unnerving creaking noise,"
			puts "After what feels like ages you ascend into the shack..."
			start
		end
		movecon = next_move.include? "use "
		if movecon == true
			puts "Nothing happens..."
			start
		else
			puts "Invalid Cookie"
		end
	end
end

def tape
	content = "You Exist,
You roam the streets not knowing if they see you or not. 
You Exist. 
You try to ignore them,their unpleasant faces scanning each other,smiles plastered. 
Your stomach fills with dissapointment,don't they know you exist? 
You Don't. 
You put your face in your hands and you fall down on the ground,
Your knees pulled up to your chest. Head pounding and hands shaking. 
You Do. 
Your brain hurts,you don't want to think anymore. 
You don't want to think of them. But,the thoughts can't leave 
Your mind. In this world you have to decide if you exist or not. 
You Exist,
You do not."
	user = Etc.getlogin
	filen = 'C:\Users\%s\Desktop\tape.txt' % [user]
	open(filen, 'w') do |f|
  f.puts content
	end
end


puts "You exist in a room."
start()

#{variable}

#put misc inspect like wall, floor, roof, etc

#get spiderweb, bone, and log, crate cavemean weapon, use on barrel, get tape.

#reactor 4 reference

#trapdoor_first  bug things.