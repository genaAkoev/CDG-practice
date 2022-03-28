def foobar(first, second)
    if ([first, second].find{|el| el == 20})
        return second
    end
    return first + second
end

puts foobar(25, 10)