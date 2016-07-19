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
  @questions = Question.all()
  erb(:index)
end

post('/surveys') do
  name = params.fetch("name")
  @survey = Survey.create({:name => name})
  @surveys = Survey.all
  @questions = Question.all()
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

delete('/surveys/:id') do
  @survey = Survey.find(params.fetch('id').to_i())
  @survey.destroy()
  @surveys = Survey.all
  @questions = Question.all()
  erb(:index)
end

post('/surveys/:id/questions') do
  @survey = Survey.find(params.fetch('id').to_i())
  description = params.fetch('description')
  survey_id = params.fetch('survey_id')
  @question = Question.create({:description => description, :survey_id => survey_id})
  @questions = Question.all()
  erb(:survey)
end

get('/surveys/:survey_id/questions/:question_id') do
  @question = Question.find(params.fetch('question_id').to_i())
  @survey = Survey.find(params.fetch('survey_id').to_i())
  erb(:question)
end

patch('/surveys/:survey_id/questions/:question_id') do
  description = params.fetch('description')
  @question = Question.find(params.fetch('question_id').to_i())
  @question.update({:description => description})
  @survey = Survey.find(params.fetch('survey_id').to_i())
  @questions = Question.all()
  erb(:survey)
end

delete('/surveys/:id/questions/:question_id') do
  @question = Question.find(params.fetch('question_id').to_i())
  @question.destroy()
  @questions = Question.all
  @survey = Survey.find(params.fetch('id').to_i())
  @surveys = Survey.all()
  erb(:survey)
end
