class Node

    attr_accessor :i, :j, :content, :f, :g, :h, :neighbours, :previous
    def initialize(i, j, content)
        @i = i
        @j = j
        @content = content
        @f = 0
        @g = 0
        @h = 0
        @neighbours = []
        @previous = false
        
    end


    def add_neighbours

        if (@i < MAZE.length - 1 && MAZE[i + 1][j].content != '#')
            @neighbours << MAZE[i + 1][j]
        end
        if @i > 0 && MAZE[i - 1][j].content != '#'
            @neighbours << MAZE[i - 1][j]
        end
        if @j > 0 && MAZE[i][j - 1].content != '#'
            @neighbours << MAZE[i][j - 1]
        end
        if (@j < MAZE[0].length - 1 && MAZE[i][j + 1].content != '#')
            @neighbours << MAZE[i][j + 1]
        end
        if (@j < MAZE[0].length - 1 && @i > 0 && MAZE[i - 1][j + 1].content != '#' )
            @neighbours << MAZE[i - 1][j + 1]
        end
        if (@j > 0 &&  @i > 0  && MAZE[i - 1][j - 1].content != '#')
            @neighbours << MAZE[i - 1][j - 1]
        end
        if (@j > 0 && @i < MAZE.length - 1 && MAZE[i + 1][j - 1].content != '#' )
            @neighbours << MAZE[i + 1][j - 1]
        end
        if (@j < MAZE[0].length - 1 && @i < MAZE.length - 1 && MAZE[i + 1][j + 1].content != '#' )
            @neighbours << MAZE[i + 1][j + 1]
        end

    end
end