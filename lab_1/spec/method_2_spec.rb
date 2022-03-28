require 'rspec'

def foobar(first, second)
    if ([first, second].find{|el| el == 20})
        return second
    end
    return first + second
end

RSpec.describe "Main" do
    it "Returns sum of arguments" do
        expect(foobar(12, 15)).to eq(27)
    end

    it "Returns second argument" do
        expect(foobar(20, 912)).to eq(912)
    end
end