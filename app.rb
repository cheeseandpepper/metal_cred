require 'pry'
require 'sinatra/base'
require 'sinatra/flash'
require_relative './models/helpers'

class App < Sinatra::Base
  set :sessions => true
  helpers Sinatra::App::Helpers
  register Sinatra::Flash

  get '/' do
    @user_location = request.location
    @upload = params[:tempfile]
    @all_users = Library.all
    @alert_message = false
    erb :index
  end


  post '/search' do
     
      @search_text = params[:search]
      #binding.pry
    redirect to "/brutal"


  end


  get '/brutal' do


    erb :brutal
  end

  post '/success' do

    
    # JAVASCRIPT ALERT   alertify.alert("Message");

    # if defined?(user_file) != "local-variable"
    #   @alert_message = true
    #   redirect to '/'
    # end
    @user_location = request.location
    result = request.location
    file_type = params["library"]["upload_file"][:type]
    user_file = params["library"]["upload_file"][:tempfile]
   

    # if file_type != "text/xml"
    #   @alert_message = true
    #   redirect to '/'
    # end
    
   
    metal_cred(user_file)
    metal_percent(user_file)
    songs(user_file)
    md5(user_file)
    artists(user_file)
    #metal_archives(user_file)
    #freebase(user_file)
    #binding.pry
    
    metal_genres_count(user_file)
    frequency_hash(user_file)
    avg_length(user_file)
    songs_without_genres(user_file)

    @user_lib_info = Library.create(:longitude => result.data["longitude"], :latitude => result.data["latitude"], :user_cred_pic => @cred_pic, :user_metal_cred => @user_cred, :metal_percent => @percent, :total_songs => @songs.size, :md5_hash => @md5_hash, :total_artists => @artists.uniq.size, :total_metal_songs => @metal_genres.size, :your_favorite_genre => @sorted.to_a.last[0], :avg_song_length => @time, :total_unknown_genre_songs => @total)
    

    redirect to "/your_metal_cred"
  

  end

  get '/alert' do

    flash[:alert] = "You were feeling blah at #{Time.now}."

  end

  get '/your_metal_cred' do
    youtube
    
    @user_location = request.location
    @all_users = Library.all
    @user_lib_info = Library.last
    #@user_file = Parser.new(params["library"]["upload_file"][:tempfile])
     #binding.pry
    erb :your_metal_cred

  end
  
end
