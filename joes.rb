 require 'sinatra'
 require 'csv'
 
get '/' do
	redirect to('/login')
end
 
get '/login' do
    csv = CSV.read("minedminds.csv")
	erb :homepage ,:locals => {:message => "Welcome Please Enter your Username & Password.", :csv => csv,}

	end

before do
	@username = params[:username]
	@password = params[:password]
end

def authenticate
	file = File.open('public/auth.csv', 'r')
	
	file.each do |user|
		username_password = user.split(",")
		username = username_password[0]
		password = username_password[1].chomp
	if  username == @username && password == @password
		@auth = 1
	end
end
end

post '/login' do
minedminds = "minedminds.csv"
minedminds = File.open(minedminds,'a')
csv = CSV.read("minedminds.csv")
minedminds.close
username = params[:username]
authenticate
	if @auth == 1
    erb :main,:locals => {:username => username,:csv => csv}
		
    else erb :homepage,:locals => {:message => "Wrong Username or Password. Please try again.",:csv => csv,:username => username,}
    end
    end

	

 