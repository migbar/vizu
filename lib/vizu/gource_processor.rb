class GourceProcessor
  #COLORS = ["33FF00", "66FF33", "99FF66", "CCFF66", "CCFF33", "CCFF00", "FFCC33", "FFCC00", "FF9900", "FF6600", "FF0000"]
	@calls = Hash.new
  COLORS = {
	"1" => "33FF00",
	"2" => "66FF33",
	"3" => "99FF66",
	"4" => "CCFF66",
	"5" => "CCFF33",
	"6" => "CCFF00",
	"7" => "FFCC33",
	"8" => "FFCC00",
	"9" => "FF0000",
	"0" => "FF0000"
	}
	

	def self.process(line)
	  begin
  	  return if line =~ /Servlet.Engine.Transports/
      process_sales_idms(line)
    rescue
      puts "Problem occurred processing line: #{line.inspect}"
    end
	end

  private
  	
  	def self.process_sales_idms(line)
  	  result = []
  	  segments = line.split("\t").to_a 
  	  
      # segments.each_with_index do |s,i|
      #   puts "segment- #{i} is #{s.inspect}"  
      # end
  	  
  	  segments[0].match(/\[(.+)\] \[Thread\-(.+)\] \w* - (\w*)/)
      puts $1
  	  timestamp = Time.parse($1).to_i.to_s
  	  thread_id = $2
  	  server = $3
  	  pool_id = segments[6].strip
  	  function = segments[7].strip
  	  duration = segments[5].strip.to_i 
  	  dealer = segments[2].strip
  	  user_id = segments[1].strip
  	  status = segments[8].strip

      # puts "server is #{server}"
      # puts "pool id is #{pool_id}"
      # puts "user_id is #{user_id}"
      # puts "dealer is #{dealer}"
      # puts "duration is #{duration}"
      # puts "function called is #{function}"
      # puts "status is #{status}"
  	  
      # resource = server + "/" + pool_id + "/" + function + "/" + (user_id == "null" ? thread_id : user_id) 
  	  resource = function.split(" ")[1] + "/" + (dealer.empty? ? "unknown" : dealer)
  	  mode = get_mode resource
  	  color = get_color(status, duration) 
  	  result << timestamp
  	  result << thread_id
  	  result << mode
  	  result << resource
  	  result << color
  	  result.join("|")
  	end

  	def self.get_mode(resource)
  		mode = @calls[resource] ||= "A"
  		@calls[resource] = "M"
  		mode
  	end

  	def self.get_color(status, duration)
  		# blue if not 'Done'
  		return "FF0000" unless duration < 1000
  		return "00FF00"
  		#make it a function of time ( from green(fast) to red(slow))
  		# right now it is just a random color for demo purposes
      # puts "COLORS ARE #{COLORS}"
      # rc = COLORS[(rand*10).to_s[0]]
      # puts "rc returned is #{rc}"
  	end
end