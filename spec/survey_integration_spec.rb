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

describe('add a question to survey path', {:type => :feature}) do
  it('lets the user add a new question to a specific survey') do
    test_survey = Survey.create({:name => "Test Survey"})
    visit('/')
    click_link('Test survey')
    expect(page).to have_content("Test survey")
    fill_in('description', :with => "What is your favorite whiskey coctail?")
    click_button("question_submit")
    expect(page).to have_content("What is your favorite whiskey coctail?")
  end
end

describe('update a survey name path', {:type => :feature}) do
  it ("updates a survey's name") do
    test_survey = Survey.create({:name => "Test Survey"})
    visit('/')
    click_link('Test survey')
    fill_in('name', :with => "New Test Survey")
    click_button("Update")
    expect(page).to have_content("New test survey")
  end
end

describe('delete a survey path', {:type => :feature}) do
  it('removes a survey from the database') do
    test_survey = Survey.create({:name => "Test Survey"})
    visit('/')
    click_link('Test survey')
    click_button('Delete')
    expect(page).to have_content("There are no surveys added yet!")
  end
end

describe('update questions path', {:type => :feature}) do
  it('updates the question description in database') do
    test_survey = Survey.create({:name => "Test Survey"})
    test_question = Question.create({:description => "This is a test question", :survey_id => test_survey.id()})
    visit('/')
    click_link('Test survey')
    click_link('This is a test question')
    fill_in("description", :with => "New test question description")
    click_button('Update')
    expect(page).to have_content('New test question description')
  end
end

describe('delete a question path', {:type => :feature}) do
  it('removes a question from the database') do
    test_survey = Survey.create({:name => "Test Survey"})
    test_question = Question.create({:description => "This is a test question", :survey_id => test_survey.id()})
    visit('/')
    click_link('Test survey')
    click_link('This is a test question')
    click_button('Delete')
    expect(page).to have_content("There are no questions saved yet!")
  end
end

describe('add a response to a question path', {:type => :feature}) do
  it('adds responses to a question') do
    test_survey = Survey.create({:name => "Test Survey"})
    test_question = Question.create({:description => "This is a test question", :survey_id => test_survey.id()})
    visit('/')
    click_link('Test survey')
    click_link('This is a test question')
    fill_in("answer", :with => "Test answer")
    click_button("Add")
    expect(page).to have_content("Test answer")
  end
end
