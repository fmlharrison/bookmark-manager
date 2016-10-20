ENV["RACK_ENV"] ||= 'development'

require 'sinatra/base'
require_relative './models/link.rb'
require_relative './models/user.rb'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
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
    @tag_name = params[:tags]
    @links = tag.links
    erb :tags
  end

  get "/users/new" do
    erb :signup
  end

  post "/users" do
    User.create(email: params[:email], password: params[:password])
    redirect "/welcome_page"
  end

  get "/welcome_page" do
    @user = User.last
    p @user
    erb :welcome_page
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
