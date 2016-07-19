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
  @questions = Question.all()
  erb(:survey)
end

patch('/surveys/:id') do
  name = params.fetch("name")
  @survey = Survey.find(params.fetch('id').to_i())
  @survey.update({:name => name})
  @questions = Question.all()
  erb(:survey)
end

post('/surveys/:id/questions') do
  @survey = Survey.find(params.fetch('id').to_i())
  description = params.fetch('description')
  survey_id = params.fetch('survey_id')
  @question = Question.create({:description => description, :survey_id => survey_id})
  @questions = Question.all()
  erb(:survey)
end
