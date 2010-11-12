class HummingParser

	def self.parse(line)
	  begin
  	  return if line =~ /Servlet.Engine.Transports/
      parse_sales_idms(line)
    rescue
      puts "Problem occurred processing line: #{line.inspect}"
    end
	end

  private
  	
  	def self.parse_sales_idms(line)
  	  segments = line.split("\t").to_a 
  	  segments[0].match(/\[(.+)\] \[Thread\-(.+)\] \w* - (\w*)/) 
  	  
  	  { :timestamp => (Time.parse($1).to_i * 1000).to_s,
  	    :server => $3,
  	    :rpc => segments[7].strip.split(" ")[1],
  	    :duration  => segments[5].strip.to_i
  	   }
  	end

end