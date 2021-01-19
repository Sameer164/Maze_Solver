require 'byebug'
require 'set'


$found = false



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


MAZE.each do |ub|
    print ub
    puts
end
puts 
puts

require_relative './nodes.rb'

$original_maze = Array.new(MAZE.length) {Array.new()}
i = 0
while i < MAZE.length
    j = 0
    while j < MAZE[0].length
        $original_maze[i][j] = MAZE[i][j]
        j += 1
    end
    i += 1
end


$original_maze.each do |ub|
    print ub
    puts
end
puts
puts



i = 0
while i < MAZE.length
    j = 0
    while j < MAZE[0].length
        temp = Node.new(i, j, MAZE[i][j])
        MAZE[i][j] = temp
        j += 1
    end
    i += 1
end

i = 0
while i < MAZE.length
    j = 0
    while j < MAZE[0].length
        no = MAZE[i][j]
        no.add_neighbours
        j += 1
    end
    i += 1
end



$path= []

$start = MAZE[$start_index[0]][$start_index[1]]
$end = MAZE[$end_index[0]][$end_index[1]]

$openSet = []
$closedSet   = []

$openSet << $start

def heuristic(a, b)
    return (a.i - b.i).abs + (a.j - b.j).abs
end

# MAIN ALGORITHM
while true
    if $openSet.length > 0
        current = $openSet.min {|nodes| nodes.f}
        
        
        if current == $end
            puts "DONE!"
            $found = true
            temp = current
            $path << temp
            while (temp.previous)
                $path << temp.previous
                temp = temp.previous
            end
            

            i = 0
            while i < $path.length
                n = $path[i]
                x = n.i
                y = n.j
                $original_maze[x][y] = '+'
                
                i += 1
            end

            $original_maze.each do |sub|
                print sub
                puts
            end


            return 
        end

        $closedSet << $openSet.delete_at($openSet.index(current))
        
        neighbours = current.neighbours
        i = 0
        while i < neighbours.length
            neighbour = neighbours[i]


            newPath = false
            if !$closedSet.include?(neighbour)
                temp = current.g + 1

                if ($openSet.include?(neighbour))
                    if temp < neighbour.g
                        newPath = true
                        neighbour.g = temp
                    end
                else
                    neighbour.g = temp
                    newPath = true
                    $openSet << neighbour
                end

                
                if newPath

                    neighbour.h = heuristic(neighbour, $end)
                    neighbour.f = neighbour.g + neighbour.h
                    neighbour.previous = current
                end


            end



            i += 1
        end
        
 


    else
        puts "Sorry, There is no solution"
        break
    end

end

if $found
    
end







