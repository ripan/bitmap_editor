class BitmapEditor

  attr_accessor :rows, :cols, :matrix, :default_color, :cmd, :cmd_options

  def initialize(args = [])
    @matrix = []
    @default_color = "O"
  end

  # create image with MxN pixels
  def create_image
    @cols = @cmd_options[0]
    @rows = @cmd_options[1]

    if is_valid_matrix?
      tmp = [];
      @rows.times do |row|
        @cols.times do |col|
          tmp << @default_color
        end
      end
      @matrix = tmp.each_slice(@cols).to_a
    else
      raise RangeError, "Invalid Matrix. Pixel co-ordinates should be pair of integers: a column number between 1 and 250, and a row number between 1 and 250"
    end
  end

  def is_valid_matrix?
    @cols.between?(1, 250) && @rows.between?(1, 250)
  end

  # Clears the table, setting all pixels to white (O)
  def clear_image
    tmp = [];
    @rows.times do |row|
      @cols.times do |col|
        tmp << @default_color
      end
    end
    @matrix = tmp.each_slice(@cols).to_a
    #display_image
  end

  # Colours the pixel (X,Y) with colour C
  def color_image_pixel
    @pixel_x = @cmd_options[0]-1
    @pixel_y = @cmd_options[1]-1
    @color = @cmd_options[2]
    @matrix[@pixel_y][@pixel_x] = @color
  end

  # vertical segment of colour C in column X between multiple rows Y1.Y2..YN
  def draw_vertical_segment
    @pixel_x = @cmd_options.first-1
    @color = @cmd_options.last

    @pixel_y1s = (@cmd_options[1]..@cmd_options[2]).to_a

    @pixel_y1s.each do |pixel_y|
      pixel_y -= 1
      @matrix[pixel_y][@pixel_x] = @color
    end
  end

  # horizontal segment of colour C in row Y between multiple columns X1.X2..XN
  def draw_horizontal_segment
    @pixel_y = @cmd_options[@cmd_options.length-2]-1
    @color = @cmd_options.last

    @pixel_xs = (@cmd_options[0]..@cmd_options[1]).to_a

    @pixel_xs.each do |pixel_x|
      pixel_x -=1
      @matrix[@pixel_y][pixel_x] = @color
    end
  end

  def display_image
    @matrix.each do |m|
      puts m.join() # m.join("\t")
    end
  end

  # Exit program
  def terminate_session
    exit
  end

  def run
    @running = true
    puts 'type ? for help'
    while @running
      print '> '
      input = gets.chomp.split()
      input = input.map {|i|  Integer(i) rescue i}

      @cmd = input.shift
      @cmd_options = input
      begin
        case @cmd
        when '?'
          show_help
        when 'X'
          exit_console
        when "I"
          create_image
        when "L"
          color_image_pixel
        when "V"
          draw_vertical_segment
        when "H"
          draw_horizontal_segment
        when "C"
          clear_image
        when "S"
          display_image
        when "X"
          terminate_session
        else
          puts "You gave me cmd: #{@cmd} #{@cmd_options.join(', ')} . I have no idea what to do with that."
          return
        end
      rescue RangeError => e
        puts  e.message
      rescue
        puts 'Invalid input. Please start by creating the Image I with M columns and N rows. Eg: I 5 6'
      end
    end
  end

  private
  def exit_console
    puts 'goodbye!'
    @running = false
  end

  def show_help
    puts "? - Help
    I M N - Create a new M x N image with all pixels coloured white (O).
    C - Clears the table, setting all pixels to white (O).
    L X Y C - Colours the pixel (X,Y) with colour C.
    V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
    H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
    S - Show the contents of the current image
    X - Terminate the session"
  end
end
