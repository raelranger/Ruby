h_arr = [
  {name: "A" , og: "B", avg: 1},
  {name: "C",og: "D",avg: 2}
]


h_arr.each do |data|
    puts "Name: #{data[:name]}  OG : #{data[:og]} AVG: #{data[:avg]}"
end
