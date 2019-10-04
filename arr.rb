matrix = [
    [2.0, 3.1, 4.2],[1.1, 2.2, ],
    [1.5, 1.6, 1.7,9]
]

i=0
j=0

for i in 0..matrix.length - 1
    for j in 0..matrix[i].length-1
        print matrix[i][j], " "
    end
    puts ""
end

