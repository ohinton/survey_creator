ENV['RACK_ENV'] = 'test'

require("rspec")
require("pg")
require("sinatra/activerecord")
require("question")
require("survey")
require("response")

RSpec.configure do |config|
  config.after(:each) do
    Question.all().each() do |question|
      question.destroy()
    end
    Survey.all().each() do |survey|
      survey.destroy()
    end
    Response.all().each() do |response|
      response.destroy()
    end
  end
end
