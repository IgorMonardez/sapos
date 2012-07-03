class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate
  before_filter :parse_date
  
  # disable implicit helper(:all) in rails3
  clear_helpers
  
  ActiveScaffold.set_defaults do |config| 
    config.ignore_columns.add [:created_at, :updated_at, :lock_version]
    config.create.link.label = :create_link
    config.delete.link.label = :delete_link
    config.show.link.label = :show_link
    config.update.link.label = :update_link
    config.search.link.label = :search_link    
    config.delete.link.confirm = :delete_message       
    #Faz com que a busca seja enviada ao servidor enquanto o usuário digita
    config.search.live = true              
    #config.search.link.cancel = false        
  end
  
  # Defines which controller and action should be shown when the base
  # URL is acessed (root route in routes.rb).
  def root
    redirect_to :controller => 'enrollments', :action => 'index'
  end
  
  private
 
  def authenticate
    authenticate_or_request_with_http_basic("Sapos") do |username, password|
      User.authenticate(username, password)
    end
  end

  # This application has custom values for date inputs, having month and year as default for most dates
  # here we nullify invalid dates that comes from the request
  # invalid dates consists in dates with year < 1000
  def parse_date
    if params[:record]
      external_key = "";
      invalid_year = false;
      params[:record].each {|key,value|
        if key.include?("1i")
          invalid_year = value.to_i < 1000
          external_key = key.split("(")[0]
        end
      }

      if invalid_year
        params[:record].delete_if{|key,value|
          key.include?("date")
        }

        params[:record][external_key] = nil
      end
    end
  end
end
