# def oh_noes  
#     puts "Before the Exception"  
#     begin  
#        puts "Just before the Exception"  
#        raise ArgumentError, "oh noes, something went wrong!!1"  
#        puts "Just after the Exception"  
#     rescue  
#        puts "Rescuing the Exception"  
#     end  
#     puts "After the Exception"  
#  end
 
#  oh_noes 

#  begin  
#     File.open('p014constructs.rb', 'r') do |f1|  
#       while line = f1.gets  
#         puts line  
#       end  
#     end  
    
#     # Create a new file and write to it  
#     File.open('test.rb', 'w') do |f2|  
#       # use "" for two lines of text  
#       f2.puts "Created by Satish\nThank God!"  
#     end  
#   rescue StandardError => msg  
#     # display the system generated error message  
#     puts msg  
#   end 
  

def rando  
    i = rand(1..10)  
        puts i
        case i
        when 1..5 then raise "This is a RuntimeError"  
        when 6..10 then raise ArgumentError, "This is an ArgumentError"  
    end  
end  
begin  
    rando  
rescue Exception  
    puts "We rescued a RuntimeError"  
rescue ArgumentError  
    puts "We rescued an Argument Error"  
end 
