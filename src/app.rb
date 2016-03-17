require('colorize')
module Draw
	class App
		VERSION = 1.1
		attr_accessor :team_list, :team_count

		def initialize
			@team_list = Array.new
			@team_count = 0
		end

		def set_team_count
			message "How many teams in the tournament?:"
			@team_count = gets.chomp.to_i
		end

		def set_team_list
			(1..@team_count).each do |i|
				print " #{i}. Team Name: ".bold.yellow
				team = gets.chomp
				@team_list << team
			end
			if (@team_count % 2) == 1
				@team_list << "-------"
				@team_count+=1
			end
			@team_list
			@team_list.shuffle!
		end

		def result
			clear
			intro
			home = Array.new
			away = Array.new
			puts "\n RESULTS: ".bold.on_red
			(1...team_count).each do |week|
				i = 0
				team_list.each do |team|
					(i % 2 == 0) ? home << team : away << team
					i+=1
				end
				print "\n "
				puts " Week #{week}:".on_green.bold
				puts "\n"
				print " \t"
				puts "Home#{" " * 15}    #{" " * 15}Away".bold.on_blue
				(0..(team_count.to_f/2).ceil-1).each do |i|
					print " \t"
					puts "#{home[i]}#{" " * (19 - home[i].length)} vs #{" " * (19 - away[i].length)}#{away[i]}".bold
				end

				a, b = -1, 2
				(1..team_count-2).each do
					a+=2 if (b % 2) == 0
					team_list[a], team_list[b] = team_list[b], team_list[a]
					b+=1
				end

				home.clear
				away.clear
			end
		end

		def intro
			clear
			puts " +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+".bold.blue
			puts " +                                                 +".bold.blue
			puts " +               FIXTURE / DRAW MASTER             +".bold.blue
			puts " +                                                 +".bold.red
			puts " +  version: #{VERSION}                author: izniburak  +".bold.red
			puts " +  licence: mit                burakdemirtas.org  +".bold.yellow
			puts " +                                                 +".bold.yellow
			puts " +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+".bold.yellow
		end

		def exit
			print "\n\n Do you want to again the draw? (Y/N): ".bold
			option = gets.chomp
			option.upcase
		end

		def clear
			print `clear`
		end

		private

		def message(msg)
			puts " "
			print " #{msg} ".bold
		end
	end
end
