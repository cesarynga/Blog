#coding:utf-8
get '/users' do
	content_type :json, :charset => 'utf-8'
	User.all.to_json(:except => :password)
end 

get '/users/:id' do
	content_type :json, :charset => 'utf-8'
	User.find(params[:id]).to_json(:except => :password)
end 

post '/users' do
	content_type :json, :charset => 'utf-8'
	raw = request.env["rack.input"].read
	json = JSON.parse(raw,:symbolize_names => true) 
	user = User.new(json)
	if user.save
		user.to_json(:except => :password)
	else
		response = {} 
		response[:status] = 'error'
		response[:message] = user.errors.full_messages
		response.to_json
	end
end

put '/users/:id' do
	content_type :json, :charset => 'utf-8'
	raw = request.env["rack.input"].read
	user = User.find(params[:id])
	json = JSON.parse(raw,:symbolize_names => true) 
	if user.update(json)
		user.to_json(:except => :password)
	else
		response = {} 
		response[:status] = 'error'
		response[:message] = user.errors.full_messages
		response.to_json
	end
end