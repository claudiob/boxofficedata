module GruffHacks
  class Gruff::Base

    # Return a formatted string representing a number value that should be
    # printed as a label.
    def label(value)

      if @spread > 10**6
        return ActionController::Base.helpers.number_to_currency(
          value/10**6, :unit => "M$", :precision => 1, :format => "%n%u")
      elsif @spread >= 10**3
        return ActionController::Base.helpers.number_to_currency(
          value/10**3, :unit => "K$", :precision => 1, :format => "%n%u")
      else
        return ActionController::Base.helpers.number_to_currency(
          value/10**0, :unit => "$", :precision => 1, :format => "%n%u")
      end
    end
  
    def initialize_ivars
      # Internal for calculations
      @raw_columns = 800.0
      @raw_rows = 800.0 * (@rows/@columns)
      @column_count = 0
      @marker_count = nil
      @maximum_value = @minimum_value = nil
      @has_data = false
      @data = Array.new
      @labels = Hash.new
      @labels_seen = Hash.new
      @sort = true
      @title = nil

      @scale = @columns / @raw_columns

      my_font_path = "#{Rails.root}/tmp/fonts/Amplitude-Light.ttf"
      @font = File.exists?(my_font_path) ? my_font_path : nil

      @marker_font_size = 21.0
      @legend_font_size = 20.0
      @title_font_size = 36.0

      @legend_box_size = 20.0

      @no_data_message = "No Data"

      @hide_line_markers = @hide_legend = @hide_title = @hide_line_numbers = false
      @center_labels_over_point = true
      @has_left_labels = false

      @additional_line_values = []
      @additional_line_colors = []
      @theme_options = {}

      @x_axis_label = @y_axis_label = nil
      @y_axis_increment = nil
      @stacked = nil
      @norm_data = nil
      @round_maximum_value = false
    end
    
    def round_maximum_value=(value)
      if value == true
        rounded_maximum_values = []

        # loop through each bar group, grab the highest value, round it up and add
                    # to rounded_maximum_values array
        highest_val = @data.each do |row|
          row_highest = row[1].sort.last
          round_to = 10 ** (row_highest.to_s.length - 1)
          rounded_maximum_values << row_highest.roundup(round_to)
        end
        # Set maximum value based on highest rounded value
        @maximum_value = rounded_maximum_values.sort.last
      end
    end
  end


  class Numeric
    def roundup(nearest=10)
      self % nearest == 0 ? self : self + nearest - (self % nearest)
    end
    def rounddown(nearest=10)
      self % nearest == 0 ? self : self - (self % nearest)
    end
  end
end