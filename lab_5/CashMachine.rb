class CashMachine
    def initialize
      if File.file?("balance.txt")
        @balance = File.read("balance.txt").to_f
      else
        @balance = File.write("balance.txt", 100.0, mode: "w").to_f
      end
    end
  
    def withdraw(value)
      if value <= @balance
        @balance -= value
        File.write("balance.txt", @balance, mode: "w")
        0
      else -1
      end
    end
  
    def deposit(value)
      if value >= 0
        @balance += value
        File.write("balance.txt", @balance, mode: "w")
        0
      else -1
      end
    end
  
    def balance
      @balance
    end
  
  end