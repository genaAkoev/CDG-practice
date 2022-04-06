# PATH_TO_FILE = "text files/students.txt"

# Вывод всех строк
def index
    return File.read(PATH_TO_FILE)
end

# Найти строку id и вывести
def find(id)
    File.foreach(PATH_TO_FILE).with_index do |str, index|
        if id-1 == index
            return str
        end
    end
end

# Найти все строки, где есть pattern
def where(pattern)
    arr = Array.new
    File.foreach(PATH_TO_FILE) do |str|
        if str.include?(pattern)
            arr.push(str)
        end
    end
    return arr
end

# Обновить строку id текстом text
def update(id, text)
    buffer = ""

    File.foreach(PATH_TO_FILE).with_index do |str, index|
        buffer += ((id-1 == index)? text + "\n" : str)
    end
    
    File.write(PATH_TO_FILE, buffer)
end

# Удалить строку id
def delete(id)
    buffer = ""
    File.foreach(PATH_TO_FILE).with_index do |str, index|
        if index == id-1
            next
        end
        buffer += str
    end
    
    File.write(PATH_TO_FILE, buffer)
end