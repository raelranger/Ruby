#intarray = [1,2,3,4,5]
#puts intarray.length
#for i in 0..(intarray.length - 1)
    #print intarray[i], " "
#end


#name = ["A","B","C","D"]
#puts name.length

#for i in 0..(name.length-1)
 #   puts name[i]
#end


#a1 = [1, "cat", 2, "dog", 3, "bird"]
#	for i in 0..(a1.length - 1)
 #   puts "a1[#{i}]= #{a1[i]}"
#	end

  #  puts #{a1[-2]}

  a1 = [1, "cat", 2, "dog", 3, "bird"]
a1[7] = 4
print a1
puts

a1[3] = "tiger"
print a1
puts

a1[4,3] = [7, "lion", 8]
print a1
puts

a1[4,2] = ["hippo"]
print a1
puts

a1[4,1] = [9, "monkey"]
print a1
puts

a1[-2..-1] = [10, "snake"]
print a1
puts

a1[4,2] = [3,"bird",9,"monkey"] 
print a1
puts

a1 [-1]= "hippo"
print a1
puts