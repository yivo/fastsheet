module BM
  module Draw
    # loading frames
    FRAMES = ['.  ', '.. ', '...'].freeze

    class <<self
      def draw(*items)
        items.each do |i|
          print i
          STDOUT.flush
        end
      end

      def hide_cursor
        draw "\e[?25l"
      end

      def show_cursor
        draw "\e[?25h"
      end

      def loading(name, text)
        @loading = true && hide_cursor

        Thread.new do
          FRAMES.cycle do |frame|
            draw([name, (text + " (#{@current}/#{@total})" + frame).to_table_cell(span: 4)].to_table_row,
                 "\n", HR, "\033[1A", "\r")
            @loading ? sleep(0.1) : break
          end

          @stopped = true
        end
      end

      def current_run(n)
        @current = n
      end

      def total_runs(n)
        @total = n
      end

      def stop_loading
        @loading = false

        until @stopped
        end

        show_cursor
      end

      # prints formatted row
      def row(*cells)
        puts cells.to_table_row, HR
      end

      def header
        puts "+#{'-' * CELL_WIDTH}+#{'-' * (TABLE_WIDTH - CELL_WIDTH - 1)}+"
        puts [EMPTY_CELL, 'Time (seconds)'.to_table_cell(span: 4)].to_table_row
        puts "|#{'Gem'.center(CELL_WIDTH)}+#{('-' * CELL_WIDTH + '+') * 4}"

        # print(
        #   '|', 'Gem'.center(CELL_WIDTH), '+',
        #   '-' * (TABLE_WIDTH - CELL_WIDTH - 1),
        #   '+', "\n"
        # )

        row('', 'User', 'System', 'Total', 'Real')
      end

      def title(text)
        puts HR_HEADER, text.to_table_row
      end
    end
  end
end
