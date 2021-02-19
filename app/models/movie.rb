class Movie < ActiveRecord::Base
    @all_ratings = ['G', 'PG', 'PG-13', 'R']
    
    def self.movie(filter, sort_t)
        return self.order(sort_t) if not filter
        self.where(:rating => filter).order(sort_t)
    end
        
    def self.all_ratings
        #self.pluck(:rating).uniq
        @all_ratings 
    end
    
    def self.selected(params, session)
        options = { }
        options[:ratings] = if params[:ratings]
            if params[:ratings].kind_of? Hash
                params[:ratings].keys
            else
                params[:ratings]
            end
        elsif session[:ratings]
            session[:ratings]
        else
            self.all_ratings
        end
        
        options[:sort_by] = if params[:sort_by]
            params[:sort_by]
        elsif session[:sort_by]
            session[:sort_by]
        else
            nil
        end
        options
    end
end

