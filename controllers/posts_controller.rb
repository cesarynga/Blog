#coding:utf-8
get '/posts' do
	content_type :json, :charset => 'utf-8'
	Post.all.to_json(:include => {:user => {:except => :password}}, :except => :user_id)
end

post '/posts' do
	content_type :json, :charset => 'utf-8'
	raw = request.env["rack.input"].read
	json = JSON.parse(raw,:symbolize_names => true) 
	post = Post.new(json)
	if post.save
		post.to_json
	else
		response = {} 
		response[:status] = 'error'
		response[:message] = post.errors.full_messages
		response.to_json
	end
end

put '/posts/:id' do
	content_type :json, :charset => 'utf-8'
	raw = request.env["rack.input"].read
	json = JSON.parse(raw,:symbolize_names => true) 
	post = Post.find(params[:id])
	if post.update(json)
		post.to_json
	else
		response = {} 
		response[:status] = 'error'
		response[:message] = post.errors.full_messages
		response.to_json
	end
end

delete '/posts/:id' do
	content_type :json, :charset => 'utf-8'
	num = Post.delete(params[:id])
	response = {} 
	if num > 0
		response[:status] = 'success'
		response[:message] = 'Post deleted'
	else
		response[:status] = 'fail'
		response[:message] = 'No post deleted'
	end
	response.to_json
end