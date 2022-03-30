require 'rspec'

def enterNumPokemon()
    loop do
        print "Enter the number of pokemons: "
        data = gets.to_s.chomp
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
        data = gets.to_s.chomp
        if data.match?(/[[:digit:]]/)
            puts "Enter a letter value!"
        elsif data.eql?("")
            puts "The value should not be empty!"
        else
            return data.to_s
        end
    end
end

def pokemonGo

    pokemons_array = Array.new
    
    num_pokemons = enterNumPokemon()

    num_pokemons.times do |i|
        p_name = enterValue(i, "name")
        p_color = enterValue(i, "color")

        pokemons_array[i] = {name: p_name, color: p_color}
    end

    pp pokemons_array
    return pokemons_array
end

RSpec.describe "Pockemon tests" do
    it "Additional method enterNumPokemon(). Puts to console 'Enter numeric value!'" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Abc", "1")
        msg = "Enter numeric value!"
        expect do
            enterNumPokemon
        end.to output("Enter the number of pokemons: #{msg}\nEnter the number of pokemons: ").to_stdout
    end

    it "Additional method enterNumPokemon(). Returns number pokemons as a Integer" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("15")
        expect(enterNumPokemon).to be_an_instance_of(Integer)
    end

    it "Additional method enterNamePokemon() Returns name" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Tirion Lanister")
        expect(enterValue(0, "name")).to eq("Tirion Lanister")
    end

    it "Additional method enterValue() Returns color" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Red")
        expect(enterValue(0, "color")).to eq("Red")
    end

    it "Main method returns pockemons as a Array" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(2, "Frodo", "Green", "Sam", "Yellow")
        expect(pokemonGo).to be_an_instance_of(Array)
    end
end