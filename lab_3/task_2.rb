PATH_TO_RESULT = "text files/results.txt"
PATH_TO_FILE = "text files/students.txt"


File.write(PATH_TO_RESULT, "")
students = File.readlines(PATH_TO_FILE)
loop do
    if students.empty?
        puts "Список студентов пуст!"
        puts "Принудительное завершение программы!"
        puts "\n\nСодержимое файла results.txt:"
        puts File.read(PATH_TO_RESULT)
        return
    end

    age = nil
    print "Введите возраст: "
    age = gets.chomp

    if (age.to_i == -1) or (students.empty?)
        puts "Завершение программы!"
        puts "\nСодержимое файла results.txt:"
        puts File.read(PATH_TO_RESULT)
        return

    elsif age.to_i < -1
        puts "Возраст не может быть отрицательным!"
        redo

    elsif age.match?(/[[:alpha:]]/)
        puts "Значение не может быть буквенным!"
        redo

    else
        student = nil

        students.each do |item|
            if item.include?(age)
                student = item
                break
            end
        end

        if student.eql?(nil)
            puts "Студент не найден!\n"
            redo
        end

        File.write(PATH_TO_RESULT, student, mode: "a")
        student_id = students.find_index(student)
        students.slice!(student_id)
        puts "Успешная запись!\n"
    end
end