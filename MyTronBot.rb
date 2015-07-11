# MyTronBot
# Author: <name>

load "map.rb"
load "printing.rb"

#NB: This AI communicates with the contest engine over
#standard out. printing.rb contains convenience methods
#which overload the puts, p and print methods such that
#they output to standard error instead.

class TronBot

	def number_of_candidacy(map,x,y)
		num = 0
		num += 1 if not map.wall?(x, y-1)
		num += 1 if not map.wall?(x, y+1)
		num += 1  if not map.wall?(x-1, y)
		num += 1  if not map.wall?(x+1, y)
		num
	end

	def max4(a,b,c,d)
		max = a
		if max < b then
			max = b
		end
		if max < c then
			max = c
		end
		if max < d then
			max = d
		end
		max
	end

	def more_next_candidacy(map)
		x, y = map.my_position
		if map.wall?(x,y-1) then
			n = 0
		else
			n = number_of_candidacy(map,x,y-1)
		end
		if map.wall?(x,y+1) then
			s = 0
		else
			s = number_of_candidacy(map,x,y+1)
		end
		if map.wall?(x-1,y) then
			w = 0
		else
			w = number_of_candidacy(map,x-1,y)
		end
		if map.wall?(x+1,y) then
			e = 0
		else
			e = number_of_candidacy(map,x+1,y)
		end
		max = max4(n,s,w,e)
		if max == n then
			"NORTH"
		elsif max == s then
			"SOUTH"
		elsif max == w then
			"WEST"
		else
			"EAST"
		end
	end


	def makemove(map)
		x, y = map.my_position
		dir = more_next_candidacy(map)
		if dir =="NORTH"
			map.make_move(:NORTH)
		elsif dir == "SOUTH"
			map.make_move(:SOUTH)
		elsif dir == "WEST"
			map.make_move(:WEST)
		else
			map.make_move(:EAST)
		end
	end


	def initialize

		while(true)

			map = Map.new()
			makemove(map)

		end

	end

end

TronBot.new()
