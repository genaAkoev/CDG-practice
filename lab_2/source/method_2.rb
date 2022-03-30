def enterNumPokemon()
    loop do
        print "Enter the number of pokemons: "
        data = gets.chomp

        if data.match?(/[[:alpha:]]/)
            puts "Enter numeric value!"
        elsif data.eql?("0")
            puts "Enter a non-zero value!" 
        else
            return data.to_i
        end
    end
end

def enterValue(index, action)
    loop do
        print "Enter #{action} of #{index} pokemon: "
        data = gets.chomp
        if data.match?(/[[:digit:]]/)
            puts "Enter a letter value!"
            redo
        elsif data.eql?("")
            puts "The value should not be empty!"
            redo
        else
            return data.to_s
        end
    end
end


def pokemonGo

    pokemons_array = Array.new
    
    num_pokemons = enterNumPokemon()

    num_pokemons.times do |i|
        p_name = p_color = nil

        p_name = enterValue(i, "name")
        p_color = enterValue(i, "color")

        pokemons_array[i] = {name: p_name, color: p_color}
    end

    pp pokemons_array
end

pokemonGo

# puts gets.chomp.match?(/[[:alpha:]]/)
# puts (Integer(gets) != nil rescue false) ? nil : "123"