require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

require("spec_helper")

describe("the index path", {:type => :feature}) do
  it("lists out the surveys") do
    test_survey = Survey.create({:name => "Test Survey"})
    visit('/')
    expect(page).to have_content("Test survey")
  end
end
