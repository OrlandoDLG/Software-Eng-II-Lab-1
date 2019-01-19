require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/class2.db")

class Post
	include DataMapper::Resource
	property :id, Serial
	property :title, Text
	property :content, Text
end

DataMapper.finalize
Post.auto_upgrade!

get "/posts" do
	@posts = Post.all
	erb :posts

end

get "/posts/new" do
	erb :new_posts
end

post "/posts/create" do

	if params["title"] && params["content"]
		po = Post.new
		po.title = params["title"]
		po.content = params["content"]
		po.save

		return " Your post was created! " + "<br/>"
	end 
end

get "/posts/delete/:id" do
	if params["id"]
		po = Post.get(params["id"])
		po.destroy if !po.nil?

		return "Item Deleted"
	end
end