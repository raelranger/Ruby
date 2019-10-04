# t = Thread.new { puts 10**10 }
# 	puts "hello"
    
    # t = Thread.new { puts 10**10 }
	# puts "hello"
	# t.join

    # def run
    #     puts "Thread is Running"
    # end
    
    # t1 = Thread.new{run()}
    # t1.join
    

    # def func1
    #     i = 0
    #     while i<=2
    #        puts "func1 at: #{Time.now}"
    #        sleep(2)
    #        i = i+1
    #     end
    #  end
     
    #  def func2
    #     j = 0
    #     while j<=2
    #        puts "func2 at: #{Time.now}"
    #        sleep(1)
    #        j = j+1
    #     end
    #  end
     
    #  puts "Started At #{Time.now}"
    #  t1 = Thread.new{func1()}
    #  t2 = Thread.new{func2()}
    #   t1.join
    #   t2.join
    #  puts "End at #{Time.now}"
     

    # def cosmicthread1
    #     puts "Is your refrigerator running?"
    #     puts "Then go catch it!"
    # end
    
    # def cosmicthread2
    #     puts "I art thou, thou art I"
    #     puts "I = Eye get it?"
    # end
    
    # def cosmicthread3
    #     puts "Human Knowledge belongs to the World"
    #     puts "Like Asprin"
    # end
    
    # cthread1 = Thread.new{cosmicthread1()}
    # cthread2 = Thread.new{cosmicthread2()}
    # cthread3 = Thread.new{cosmicthread3()}
    
    # #cthread1.join()
    # #cthread2.join()
    # #cthread3.join()
    


  
    # A BankAccount has a name, a checking amount, and a savings amount  
    class BankAccount  
      def initialize(name, checking, savings)  
        @name,@checking,@savings = name,checking,savings  
        @lock = Mutex.new  # For thread safety  
      end  
      
      # Lock account and transfer money from savings to checking  
      def transfer_from_savings(x)  
        @lock.synchronize {  
          @savings -= x  
          @checking += x  
        }  
      end  
      
      # Lock account and report current balances  
      def report  
        @lock.synchronize {  
          puts "#@name\nChecking: #@checking\nSavings: #@savings"  
        }  
      end  
    end 
    

b = BankAccount.new("Arm", 100, 300)
b.transfer_from_savings(200)
b.report