require 'rspec'

def checkWord(word)
    s_word = word.is_a?(String) ? word : word.to_s
    if s_word.chars.last(2).join.eql?("cs")
        return 2 ** s_word.length
    else
        return s_word.reverse
    end
end

RSpec.describe "Main" do
    it "Returns the number 2 to the extent of the word length" do
        expect(checkWord("dacs")).to eq(16)
    end

    it "Returns reverse word" do
        expect(checkWord("cloud")).to eq("duolc")
    end

    it "Returns word as a string" do
        expect(checkWord("nil")).to be_an_instance_of(String)
    end

    it "Returns empty string" do
        expect(checkWord(nil)).to eq("")
    end
end