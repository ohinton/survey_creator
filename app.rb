require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/survey")
require("./lib/question")
require('pg')
require('pry')

get('/') do
  @surveys = Survey.all
  erb(:index)
end

post('/surveys') do
  name = params.fetch("name")
  @survey = Survey.create({:name => name})
  @surveys = Survey.all
  erb(:index)
end

get('/surveys/:id') do
  @survey = Survey.find(params.fetch('id').to_i())
  erb(:survey)
end
