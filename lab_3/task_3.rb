PATH_TO_BALANCE = "text files/balance.txt"
$balance = File.exist?(PATH_TO_BALANCE) ?
    File.read(PATH_TO_BALANCE).to_f : 100.0

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
            File.write(PATH_TO_BALANCE, $balance+amount)
            $balance += amount
            puts "Deposit is successfully\n" +
            "The new balance value is $#{$balance}\n\n"
            return
        end
    end
end

def withdraw
    if $balance <= 0
        puts "Insufficient funds!\n"
        puts "The current balance is $#{$balance}\n\n"
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
        when amount > $balance
            puts "The amount of the issue cannot\n"
            +"be more than the current balance!\n"
        else
            File.write(PATH_TO_BALANCE, $balance-amount)
            $balance -= amount
            puts "Withdraw is successfully\n" +
            "The new balance value is $#{$balance}\n\n"
            return
        end
    end
end

loop do
    puts "Select an action:" +
    "\nD - deposit money" +
    "\nW - withdraw money" +
    "\nB - show balance" +
    "\nQ - quit\n\n"
    print "Type and press Enter: "
    case gets.chomp.to_s
    when "D", "d"
        deposit()
    when "W", "w"
        withdraw()
    when "B", "b"
        puts "Your balance is $#{$balance}\n\n"
    when "Q", "q"
        return
    else
        puts "Unknown command\n"
    end
end