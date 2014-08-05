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
	puts "Look"
	puts "Use"
	puts "Inspect"
	puts "Take"
end

@door_leads = 'the unknown'  #when inspected =outside
@door_status = ''  #locked/unlocked
@fireplace_status = '' #burning/not  burning
@clock_status = ''  #broken/fixed
@trapdoor_status = ''  #locked/unlocked  

#add variables to the looks,
def look()
  puts "A%s [Door] lies north of you leading to %s," % [@door_status, @door_leads]
  puts "A%s [Fireplace] is along the west wall" % [@fireplace_status]
  puts "A [Table] is in the center of the room"   #stuff ia on the table
  puts "A#{@clock_status} grandfather styled [Clock] is in the north-east corner of the room" #% [@clock_status]
  puts "A%s [Trapdoor] is against the south wall" % [@trapdoor_status]
  puts "A pile of wooden logs is in the south-east corner of the room" #put logs in firepalce evry so often or bad things happen
end

def inspect()
	puts "What would you like to inspect?"

end

def start
	puts "You start in a wooden shack."
	while true
	prompt; next_move = gets.chomp.downcase
	 	if next_move == "help"
 			help
		end
		if next_move == "inventory"
			inventory
		end
		if next_move == "map"
			map_shack
		end
		if next_move == "look"
			look
		end
		if next_move == "exit"
			exit
		end
		if next_move == "inspect door"
			puts "The door is locked,"
			@door_status = " locked"
			puts "You look through the small peakhole in the door,"; puts "It appears to lead into a forest"; puts "You cant see anything else"
			@door_leads = "a forest"
		end
		if next_move == "inspect clock"
			puts "Its a broken clock with the hands stuck on 4:20"
			@clock_status = " broken"
		end
		if next_move == "inspect fireplace"
			puts "The fireplace contains hot embers"
		else
			puts "Invalid Cookie"
		end
	end
end

start()

#put inspect door/fireplace/etc  method or if statement in start

#trapdoor will lead to celler

#{variable}