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

describe("the add a survey path", {:type => :feature}) do
  it("lets a user add a survey name to the database") do
    visit('/')
    fill_in("name", :with => "Test Survey")
    click_button("Submit")
    expect(page).to have_content("Test survey")
  end
end

describe('the survey details path', {:type => :feature}) do
  it('lets the user find the info for a survey') do
    test_survey = Survey.create({:name => "Test Survey"})
    visit('/')
    click_link('Test survey')
    expect(page).to have_content("Test survey")
  end
end
