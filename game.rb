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

def map_cellar()   #come back to this
	puts 'not implimented yet'
end

def help()
	puts "Commands should be straight forward and simple (hopefully)"
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

@table_inspect = true

@fireburn = false

@key1 = false #fireplace key

#add variables to the looks,
def look()
  puts "A%s [Door] lies north of you leading to %s," % [@door_status, @door_leads]
  puts "A%s [Fireplace] is along the west wall" % [@fireplace_status]
  puts "A [Table] is in the center of the room"   #stuff on the table
  puts "A%s grandfather styled [Clock]%s is in the north-east corner of the room" % [@clock_status, @clock_hands]
  puts "A%s [Trapdoor] is against the south wall" % [@trapdoor_status]
  puts "A pile of wooden logs is in the south-east corner of the room" #put logs in firepalce evry so often or bad things happen
end

def start
	while true
	puts ""
	prompt; next_move = gets.chomp.downcase
#basic commands
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
			puts "The table has a [Screwdriver] on it."
			@table_inspect = true; start  #stuff on table to escape
		end
		if next_move == "inspect wall" or next_move == "inspect walls"
			puts "Your standard reinforced walls, your not getting out through there"; start
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
			ininv = @inventory.include? "Screwdriver"
				if ininv == false
					@inventory << "Screwdriver"
					puts "You take the [Screwdriver]"
				else
					puts "You already have the [Screwdriver]"
				end
			start
			end
#use
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
		else 
			puts "Invalid Cookie"
		end
	end
end

puts "You start in a wooden shack."
start()

#put inspect door/fireplace/etc  method or if statement in start

#trapdoor will lead to celler

#{variable}

#put misc inspect like wall, floor, roof, etc