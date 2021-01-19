require 'byebug'

file = File.open('maze1.txt')
ARR = file.readlines.map(&:chomp)
file.close

MAZE = Array.new(ARR.length - 2){Array.new()}

i = 1

while i < ARR.length - 1
    n = ARR[i][1..-2].split('')
    ne = []
    j = 0
    while j < n.length
        if n[j] == '*'
            ne[j] = '#'
        elsif n[j] == ' '
            ne[j] = 'O'
        else
            ne[j] = n[j]
        end
        j += 1
    end
 
    MAZE[i - 1] = ne
    i += 1
end





$start_index = []
$end_index = []
MAZE.each_with_index do |sub, ind1|
    if sub.include?('S')
        $start_index << ind1
    elsif sub.include?('E')
        $end_index << ind1
    end

    if sub.include?('S') || sub.include?('E')
        sub.each_with_index do |le, ind2|
            if le == 'S'
                $start_index << ind2
            elsif le == "E"
                $end_index << ind2
            end
        end
    end
end



$found = false
$travelled = []

def is_safe(maze, x, y)
    
    if (x >= 0 && y < maze[0].length && y >= 0 && x < maze.length)
        if (maze[x][y] == 'O' || maze[x][y] == 'S' || maze[x][y] == 'E') && !$travelled.include?([x, y])
            
            return true
        end
    end
    return false
end

def tracePath(maze, start_x, start_y, end_x, end_y, sols)
    
    if (start_x == end_x && start_y == end_y && maze[start_x][start_y] == "E")
        sols[start_x][start_y] = '+'
        $found = true
        return true
    end
    
    if (is_safe(maze, start_x, start_y) && !($found))
        sols[start_x][start_y] = '+'
        $travelled << [start_x, start_y]

        if (tracePath(maze, start_x - 1, start_y, end_x, end_y, sols))
            return true
        end
        
        
        if (tracePath(maze, start_x, start_y + 1, end_x, end_y, sols))
            return true
        end
        
        if (tracePath(maze, start_x + 1, start_y, end_x, end_y, sols))
            return true
        end

        if (tracePath(maze, start_x, start_y - 1, end_x, end_y, sols))
            return true
        end


        

      

        

        sols[start_x][start_y] = '#'
       

    end
    
    
    return false



end


def printMazePath(maze, start_x, start_y, end_x, end_y)
    $sols = Array.new(MAZE.length) {Array.new()}
    
    i = 0
    while i < MAZE.length
        j = 0
        while j < MAZE[0].length
            $sols[i][j] = MAZE[i][j]
            j += 1
        end
        i += 1
    end

    
   


    if !tracePath(maze, start_x, start_y, end_x, end_y, $sols)
        puts "Sorry! There is no such path"
        $sols.each do |sub|
            print sub
            puts
        end
        return false
    end
    
    MAZE.each do |sub|
        print sub
        puts
    end
    puts 
    puts
    puts
    
  
        



    $sols.each do |sub|
        print sub
        puts
    end
    return true



    
end

debugger

printMazePath(MAZE, $start_index[0], $start_index[1], $end_index[0], $end_index[1])






