#!/bin/env ruby
# encoding: utf-8

require "sinatra"
require "mysql2"

@@dbClient = Mysql2::Client.new({:database => "psu", :username => "root", :password => "", :host => "localhost", :reconnect => true})

get "/resultados" do
    
    params.each do |key, value|
        val = value.upcase
        val = val.gsub(/%/,"")
        val = val.gsub(/[ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž]/,"?")
        params[key] = val
    end
    nombre = "%" + params[:nombres] + "%" + params[:apellido_pat] + "%" + params[:apellido_mat] + "%"
    query = "SELECT * FROM respsu_2013 WHERE nombre like '#{nombre}' AND (mat > 0 OR le > 0) LIMIT 0, 50"
    puts query
    results = @@dbClient.query(query);
    
	erb :resultados, :locals => {"results" => results}
end

get "/" do 
    send_file File.join(settings.public_folder, 'index.html')
end
