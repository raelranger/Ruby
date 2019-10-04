require 'ruby2d'

# set resizable: true
# set diagnostics: true
# puts get :width # return

# set title: "Hello Triangle"
# Triangle.new(  
#     x1: 320, y1:  50,  x2: 540, y2: 430,  x3: 100, y3: 430,  color: ['red', 'green', 'blue']
# )


# tick = 0
# update do  
#     if tick % 60 == 0    
#     set background: 'random'  
# end  
# tick += 1
# end


# t = Time.now
# update do  
#     # Close the window after 5 seconds 
#      if Time.now - t > 5 then close 
#     end
#     end
        # show

        # Define a square shape.
        @square = Square.new(x: 10, y: 20, size: 25, color: 'blue')
        # Define the initial speed (and direction).
        @x_speed = 0
        @y_speed = 0
        @sz =0
        # Define what happens when a specific key is pressed.
        # Each keypress influences on the  movement along the x and y axis.
        on :key_down do |event|  
            if event.key == 'j'    
                @x_speed = -2   
                 @y_speed = 0
                 @sz = -1  
                elsif event.key == 'l'    
                    @x_speed = 2   
                     @y_speed = 0 
                     @sz = 1
                    elsif event.key == 'i'   
                         @x_speed = 0   
                          @y_speed = -2
                          @sz =-1
                        elsif event.key == 'k'    
                            @x_speed = 0 
                            @y_speed = 2
                              @sz = 1
                        
                            elsif event.key == 's'
                                @x_speed = 0    
                                @y_speed = 0 
                                @sz =0 
                            end  
                    end
                       update do  
                                @square.x += @x_speed 
                                 @square.y += @y_speed
                                 @square.size += @sz
                                 
                                 end
                                 show