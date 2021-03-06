class GrossesController < ApplicationController

    # GET /grosses
    # GET /grosses.xml
    def index
      @movie = Movie.find(params[:movie_id], :include => [{:results => :period}])
      periods = @movie.results.collect(&:period)
      first_period, last_period = periods.min, periods.max
      if first_period.nil? || last_period.nil?
        @results = []
      else
        @results = Result.all(:include => :period, :select => "results.id, results.gross, 'Weekend' as period_type, weekends.id as period_id",
        :joins => "RIGHT JOIN weekends ON results.period_type = 'Weekend' AND results.period_id = weekends.id AND results.measurable_type = 'Movie' and results.measurable_id = #{@movie.id}",
        :conditions => "(year > #{first_period.year} && year <= #{last_period.year} && week < #{first_period.week} && week < #{last_period.week}) || (year < #{last_period.year} && year >= #{first_period.year} && week > #{last_period.week} && week > #{first_period.week}) || (year between #{first_period.year} and #{last_period.year} && week between #{first_period.week} and #{last_period.week}) || (year > #{first_period.year} && year < #{last_period.year})" )
      end
      
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @results }
        format.pie  { 
          g = Gruff::Pie.new
          g.title = "Weekend #{params[:weekend_id]}"
          @results.each do |result|
            g.data @movie.title, result.gross
          end
          send_data g.to_blob('gif'), :disposition => 'inline', :type => 'image/gif' 
        }
        format.line  { 
          g = Gruff::Line.new("800x300") # ("#{30*@results.size}x600")
          title = @movie.title
          g.title = "U.S. Weekend Gross"
          g.round_maximum_value = true
          g.hide_title = true
          g.hide_legend = true
          g.hide_dots = true
          g.bottom_margin = 0
          g.left_margin = 0
          g.right_margin = 0
          g.top_margin = 0
          
          g.data title, @results.collect{|r| r.gross.to_i unless r.gross.nil?}
          g.minimum_value = 0
#          @results.each_with_index do |r, i| 
#            g.labels[i] = (Date.civil(r.period.year,1,1).first_friday + (r.period.week).weeks).to_s(:short)
#          end
          rfirst = @results.first
          rlast = @results.last
          g.labels[0] = (Date.civil(rfirst.period.year,1,1).first_friday + (rfirst.period.week).weeks).to_s  
          g.labels[@results.length - 1] = (Date.civil(rlast.period.year,1,1).first_friday + (rlast.period.week).weeks).to_s  

  #       @results.each_with_index do |r, i| g.labels[i] = r.ends_on end
          send_data g.to_blob('gif'), :disposition => 'inline', :type => 'image/gif' 
        }

      end
    end

end
