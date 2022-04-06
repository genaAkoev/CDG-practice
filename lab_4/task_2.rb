module Resource
    def connection(routes)
        if routes.nil?
        puts "No route matches for #{self}"
        return
        end

        loop do
        print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
        verb = gets.chomp
        break if verb == 'q'

        action = nil

        if verb == 'GET'
            print 'Choose action (index/show) / q to exit: '
            action = gets.chomp
            break if action == 'q'
        end


        action.nil? ? routes[verb].call : routes[verb][action].call
        end
    end
end
  
class PostsController
    extend Resource
    PATH_TO_POSTS = "text files/posts.txt"

    def initialize
        if File.exist?(PATH_TO_POSTS)
            @posts = File.readlines(PATH_TO_POSTS)
        else
            File.write(PATH_TO_POSTS,"")
            @posts = []
        end
    end

    def index
        puts "Current posts:"
        @posts.each_with_index do |post, index|
            puts "#{index}: #{post}"
        end
        puts "\n"
    end

    def show
        loop do
            print "Enter the index: "
            id = gets.chomp
            if id.to_s.match?(/[[:alpha:]]/)
                puts "The value must not be alphabetic!"
                redo
            elsif id.to_i < 0
                puts "The value must not be less than zero!"
                redo
            elsif id.to_i >= @posts.length()
                puts "The value must not be more than array length!"
                redo
            else
                puts "Current post:"
                @posts.each_with_index do |post, index|
                    if id.to_i == index
                        puts "#{index}: #{post}\n"
                        return
                    end
                end
            end
        end
    end

    def create
        print "Enter the text: "
        text = gets.chomp.to_s
        @posts.push(text)
        File.write(PATH_TO_POSTS, text + "\n", mode: "a")
        puts "Added new post:\n" +
            "#{@posts.length-1}: #{text}\n\n"
    end

    def update
        id = nil
        loop do
            print "Enter the index: "
            id = gets.chomp.to_i
            if id.to_s.match?(/[[:alpha:]]/)
                puts "The value must not be alphabetic!"
                redo
            elsif id >= @posts.length
                puts "The value must not be more than array length!"
                redo
            elsif id < 0
                puts "The value must not be less than zero!"
                redo
            else
                break
            end
        end
        print "Enter the text: "
        text = gets.chomp.to_s
        @posts[id] = text
        File.open(PATH_TO_POSTS, 'w') { |file| file.write("#{@posts.join("\n")}\n") }
    end

    def destroy
        id = nil
        loop do
            print "Enter the index: "
            id = gets.chomp.to_i
            if id.to_s.match?(/[[:alpha:]]/)
                puts "The value must not be alphabetic!"
                redo
            elsif id >= @posts.length
                puts "The value must not be more than array length!"
                redo
            elsif id < 0
                puts "The value must not be less than zero!"
                redo
            else
                break
            end
        end
        @posts.delete_at(id)
        File.open(PATH_TO_POSTS, 'w') { |file| file.write("#{@posts.join("\n")}\n") }
    end
end

class CommentsController
    extend Resource
    PATH_TO_COMMENTS = "text files/comments.txt"
  
    def initialize
        if File.exist?(PATH_TO_COMMENTS)
            @comments = File.readlines(PATH_TO_COMMENTS)
        else
            File.write(PATH_TO_COMMENTS,"")
            @comments = []
        end
    end
  
    def index
        puts "Current comments:"
        @comments.each_with_index do |comment, index|
            puts "#{index}: #{comment}"
        end
        puts "\n"
    end

    def show
        loop do
            print "Enter the index: "
            id = gets.chomp
            if id.to_s.match?(/[[:alpha:]]/)
                puts "The value must not be alphabetic!"
                redo
            elsif id.to_i < 0
                puts "The value must not be less than zero!"
                redo
            elsif id.to_i >= @comments.length()
                puts "The value must not be more than array length!"
                redo
            else
                puts "Current comment:"
                @comments.each_with_index do |comment, index|
                    if id.to_i == index
                        puts "#{index}: #{comment}\n"
                        return
                    end
                end
            end
        end
    end

    def create
        print "Enter the text: "
        text = gets.chomp.to_s
        @comments.push(text)
        File.write(PATH_TO_COMMENTS, text + "\n", mode: "a")
        puts "Added new comment:\n" +
            "#{@comments.length-1}: #{text}\n\n"
    end

    def update
        id = nil
        loop do
            print "Enter the index: "
            id = gets.chomp.to_i
            if id.to_s.match?(/[[:alpha:]]/)
                puts "The value must not be alphabetic!"
                redo
            elsif id >= @comments.length
                puts "The value must not be more than array length!"
                redo
            elsif id < 0
                puts "The value must not be less than zero!"
                redo
            else
                break
            end
        end
        print "Enter the text: "
        text = gets.chomp.to_s
        @comments[id] = text
        File.open(PATH_TO_COMMENTS, 'w') { |file| file.write("#{@comments.join("\n")}\n") }
    end

    def destroy
        id = nil
        loop do
            print "Enter the index: "
            id = gets.chomp.to_i
            if id.to_s.match?(/[[:alpha:]]/)
                puts "The value must not be alphabetic!"
                redo
            elsif id >= @comments.length
                puts "The value must not be more than array length!"
                redo
            elsif id < 0
                puts "The value must not be less than zero!"
                redo
            else
                break
            end
        end
        @comments.delete_at(id)
        File.open(PATH_TO_COMMENTS, 'w') { |file| file.write("#{@comments.join("\n")}\n") }
    end
end
  
class Router
    def initialize
        @routes = {}
    end
  
    def init
        resources(PostsController, 'posts')
        resources(CommentsController, 'comments')

        loop do
        print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
        choise = gets.chomp

        PostsController.connection(@routes['posts']) if choise == '1'
        CommentsController.connection(@routes['comments']) if choise == '2'
        break if choise == 'q'
        end

        puts 'Good bye!'
    end
  
    def resources(klass, keyword)
        controller = klass.new
        @routes[keyword] = {
        'GET' => {
            'index' => controller.method(:index),
            'show' => controller.method(:show)
        },
        'POST' => controller.method(:create),
        'PUT' => controller.method(:update),
        'DELETE' => controller.method(:destroy)
        }
    end
end
  
router = Router.new
router.init