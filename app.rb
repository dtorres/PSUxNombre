require "sinatra"

get "/resultados" do
	"Not Yet"
end

get "/" do 
    send_file File.join(settings.public_folder, 'index.html')
end
