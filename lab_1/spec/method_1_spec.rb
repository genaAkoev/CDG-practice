require 'rspec'

def greeting
    print "Введите ваше имя: "
    name = gets.to_s.chomp
    print "Введите вашу фамилию: "
    surname = gets.to_s.chomp
    print "Введите ваш возраст: "
    age = gets.to_i
    if (age < 18)
        "Привет, #{name} #{surname}! Тебе меньше 18 лет, но начать учиться программировать никогда не рано."
    else
        "Привет, #{name} #{surname}! Самое время заняться делом."
    end
end

RSpec.describe "Main" do

    it "Returns greeting, name and surname" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("A", "G", 18)
        expect(greeting.match("!").pre_match).to eq("Привет, A G")
    end

    it "Verification of legal age" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Геннадий", "Акоев", 19)
        expect(greeting).to include("Самое время")
    end

    it "Presence of a digit in name and surname" do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Геннадий", "Акоев", 18)
        expect(!(greeting.match("!").pre_match.count("0-9") > 0)).to eq(true)
    end
end