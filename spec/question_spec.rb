require("spec_helper")

describe(Question) do
  describe("#survey") do
    it('tells which survey it belongs to') do
      test_survey = Survey.create({:name => "Favorite Drinks"})
      test_question = Question.create({:description => "What is your favorite whiskey coctail", :survey_id => test_survey.id})
      expect(test_question.survey()).to(eq(test_survey))
    end
  end
end
