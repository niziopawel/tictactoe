class Board
  attr_reader :locations, :size, :winning_combinations

  def initialize(args)
    @size = args[:size] || 3
    @winning_combinations = horizontal_lines + vertical_lines + diagonal_lines

    @locations = [nil] * (size**2)
  end

  def taken?(location)
    !empty?(location)
  end

  def available?(location)
    locations[location - 1].nil?
  end

  def set_move(location, player)
    locations[location - 1] = player
  end

  def render
    puts

    locations.each_slice(size).with_index do |row, index|
      puts '-' * size + '---' * (size - 1) unless index.zero?
      puts row.map { |r| mark r }.join(' | ')
    end

    puts
  end

  def win?
    winner = nil

    @winning_combinations.each do |wc|
      line = [locations[wc[0]], locations[wc[1]], locations[wc[2]]].compact

      winner = winning_line?(line)
      break if winner
    end

    winner || false
  end

  def winning_line?(line)
    return line.first if line.count == size && line.all? { |l| l == line.first }
  end

  def draw?
    return false unless locations.none?(nil)

    win? ? false : true
  end

  private

  def mark(location)
    location&.mark || ' '
  end

  def horizontal_lines
    lines = []

    size.times do |i|
      line = []
      size.times do |j|
        line << i * size + j
      end
      lines << line
    end
    lines
  end

  def vertical_lines
    lines = []
    size.times do |i|
      line = []

      size.times do |j|
        line << i + j * size
      end
      lines << line
    end

    lines
  end

  def diagonal_lines
    lines = []

    first_diagonal = []
    size.times do |i|
      first_diagonal << size * i + i
    end

    second_diagonal = []
    size.times do |i|
      second_diagonal << (size * (i + 1) - (i + 1))
    end

    lines << first_diagonal << second_diagonal
  end
end
