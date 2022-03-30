def checkWord(word)
    s_word = word.is_a?(String) ? word : word.to_s
    if s_word.chars.last(2).join.eql?("cs")
        return 2 ** s_word.length
    else
        return s_word.reverse
    end
end

puts checkWord(nil)