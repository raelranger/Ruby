class Todo
    def initialize
        @todos =[]
    end

    def input_todo
        loop do   
            print "\nGet in puts todo : "
            todo = gets.chomp()
            print "Get Data : "
            data = gets.chomp()
            if (todo !='' && data != '')
                @todos.push({todo: todo, data: data})
            else
                break
            end
        end

    end
    def menu
        loop do
            show()
            puts "[1] Todo [2] Done"
            g_todo = gets.chomp
            print "You pick :#{g_todo}"
        
            if (g_todo == "1")
                input_todo()
            elsif (g_todo == "2")
                done()
            else
                break
            end
        end

    end

    def done
        loop do 
            show()
            print "\nI'm done : "
            g_done = gets.chomp
            if( g_done != '')
                @todos.delete_at(g_done.to_i - 1)
            else
                break
            end
        end
    end


    def show
        i = 1
        @todos.each do |todo|
            puts "\n[#{i}]Todo : #{todo[:todo]} Data : #{todo[:data]}" 
            i += 1
        end
        
    end
end

h = Todo.new
h.input_todo()
h.menu
