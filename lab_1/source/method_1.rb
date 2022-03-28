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

puts greeting