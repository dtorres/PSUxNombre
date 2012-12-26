require "sinatra"

get "/resultados" do
	"Not Yet"
end

get "/" do 
    send_file "public/index.html"
end