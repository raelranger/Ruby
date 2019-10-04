def deck_uno
    uno = { deck: [] }

    colors = ["red", "yellow","green", "blue"]
    special_cards = ["wild_draw", "draw_four"]

    colors.collect do |zero_color| 
        uno[:deck].push({color: zero_color, value: 0, point: 0})
    end
    
    # draw_four
    special_cards.collect do |special_card|
        (1..9).each do |i|
            uno[:deck].push({color: "red", value: i, point: i})
            uno[:deck].push({color: "yellow", value: i, point: i})
            uno[:deck].push({color: "green", value: i, point: i})
            uno[:deck].push({color: "blue", value: i, point: i})
        end
    
        colors.collect do |action_color|
            uno[:deck].push({color: action_color, value: "skip", point: 10})
            uno[:deck].push({color: action_color, value: "revers", point: 10})
            uno[:deck].push({color: action_color, value: "draw_two", point: 10})
            uno[:deck].push({color: "black", value: special_card, point: 50})
        end
    end
    
    return uno[:deck]
end

puts deck_uno
puts deck_uno.length 