class CashMachine
    PATH_TO_BALANCE = "text files/balance.txt"

    def initialize(balance = 100.0)
        @balance = balance
    end

    def getBalance
        @balance
    end

    def setBalance(balance)
        @balance = balance
    end

    def deposit
        puts "\nDeposit\n"
        puts "Reminder: The amount must be above zero!"
        loop do
            print "Enter the deposit amount: "
            amount = gets.chomp.to_f
            case 
            when amount <= 0
                puts "The amount must be above zero!"
            else
                self.setBalance(self.getBalance() + amount)
                File.write(PATH_TO_BALANCE, self.getBalance())
                puts "Deposit is successfully\n" +
                "The new balance value is $#{getBalance()}\n\n"
                return
            end
        end
    end

    def withdraw
        if self.getBalance() <= 0
            puts "Insufficient funds!\n"
            puts "The current balance is $#{self.getBalance()}\n\n"
            return
        end
    
        puts "\nWithdraw\n"
        puts "Reminder: The amount must be above zero\n" +
        "and below or equal to the current balance!\n"
    
        loop do
            print "Enter the issue amount: "
            amount = gets.chomp.to_f
            case 
            when amount <= 0
                puts "The amount must be above zero!"
            when amount > self.getBalance()
                puts "The amount of the issue cannot\n"
                +"be more than the current balance!\n"
            else
                self.setBalance(self.getBalance() - amount)
                File.write(PATH_TO_BALANCE, self.getBalance())
                puts "Withdraw is successfully\n" +
                "The new balance value is $#{self.getBalance()}\n\n"
                return
            end
        end
    end

    def self.init
        cashMachine = File.exist?(PATH_TO_BALANCE) ?
            CashMachine.new(File.read(PATH_TO_BALANCE).to_f) :
            CashMachine.new()
        
        loop do
            puts "Select an action:\n" +
            "D - deposit money\n" +
            "W - withdraw money\n" +
            "B - show balance\n" +
            "Q - quit\n\n"
            print "Type and press Enter: "
            case gets.chomp.to_s
            when "D", "d"
                cashMachine.deposit()
            when "W", "w"
                cashMachine.withdraw()
            when "B", "b"
                puts "Your balance is $#{cashMachine.getBalance()}\n\n"
            when "Q", "q"
                return
            else
                puts "Unknown command\n\n"
            end
        end
    end
end

CashMachine.init