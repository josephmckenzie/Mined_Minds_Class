 require 'sinatra'
 require 'csv'
 
get '/' do
	redirect to('/login')
end
 
get '/login' do
    csv = CSV.read("minedminds.csv")
	csv2 = CSV.read("minedminds2.csv")
	erb :homepage ,:locals => {:message => "Welcome Please Enter your Username & Password.", :csv => csv, :csv2 => csv2}

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

minedminds2 = "minedminds2.csv"
minedminds2 = File.open(minedminds2,'a')
csv2 = CSV.read("minedminds2.csv")
minedminds2.close

username = params[:username]
authenticate
	if @auth == 1 &&  params[:username] == "MinedMinds"
		erb :management,:locals => {:username => username,:csv => csv}
		
	elsif @auth == 1 
		erb :main,:locals => {:username => username,:csv => csv}
	
	else erb :homepage,:locals => {:message => "Wrong Username or Password. Please try again.",:csv => csv,:username => username, :csv => csv, :csv2 => csv2}
    
	
	end
end
		

get '/management' do
	csv = CSV.read("minedminds.csv")
		erb :management,:locals => {:csv => csv}

end
 
post '/management' do

username = params[:Username]
assignment = params[:Assignment]
videohelp = params[:VideoHelp]
bloghelp = params[:BlogHelp]
status = params[:Status]

minedminds = "minedminds.csv"
minedminds = File.open(minedminds,'a')


minedminds.write( username + "," + assignment + "," + videohelp + "," + bloghelp + "," + status + "\r")
minedminds.close
	redirect '/management'

end