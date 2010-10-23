class HummingProcessor

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
  	  result = {}
  	  segments = line.split("\t").to_a 
  	  segments[0].match(/\[(.+)\] \[Thread\-(.+)\] \w* - (\w*)/)
  	  result[:timestamp]  = (Time.parse($1).to_i * 1000).to_s
  	  result[:server]  = $3
  	  result[:rpc] = segments[7].strip.split(" ")[1]
  	  result[:duration] = segments[5].strip.to_i 
  	  result.to_json
  	end

end