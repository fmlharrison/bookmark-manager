ENV["RACK_ENV"] ||= 'development'

require 'sinatra/base'
require_relative './models/link.rb'
require_relative './models/user.rb'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super_secret'


  get '/' do
    erb :index
  end

  get '/links' do
    @links = Link.all
    erb :links
  end

  post "/links" do
    link = Link.new(url: params[:url], title: params[:title])
    tag_names = params[:tags].split(",").map!(&:strip)
    tags =  Tag.create_tags(tag_names)
    tags.each {|tag| link.tags << tag}
    link.save
    redirect "/links"
  end

  get "/links/new" do
    erb :add_link
  end

  get "/tags/:name" do
    tag = Tag.all(name: params[:tags])
    @links = tag ? tag.links : []
    erb :links
  end

  get "/users/new" do
    erb :signup
  end

  post "/users" do
    user = User.create(email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect "/links"
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
