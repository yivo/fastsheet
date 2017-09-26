module BM
  # columns count
  COLUMNS = 5

  # cell width with no borders
  CELL_WIDTH = 13

  # table width with no borders
  # `COLUMNS - 1` is number of column separators
  TABLE_WIDTH = CELL_WIDTH * COLUMNS + (COLUMNS - 1)

  # well, empty cell
  EMPTY_CELL = ' ' * CELL_WIDTH

  # horizontal rule for table with multiple columns
  HR = "+#{('-' * CELL_WIDTH << '+') * COLUMNS}".freeze

  # horizontal rule for header
  HR_HEADER = "+#{'-' * TABLE_WIDTH}+".freeze
end

class Object
  def to_table_row(value = self)
    value.to_s.center(BM::TABLE_WIDTH).surround('|')
  end

  def to_table_cell(value = self, span: 1)
    value.to_s.center(BM::CELL_WIDTH * span + (span - 1))
  end
end

class String
  def surround(c)
    insert(0, c).insert(-1, c)
  end
end

class Array
  def to_table_row
    map(&:to_table_cell).join('|').surround('|')
  end
end

class Float
  def to_table_cell
    super round(3)
  end
end
