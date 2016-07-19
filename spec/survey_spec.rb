require("spec_helper")

describe(Survey) do
  it("capitalizes the name of the survey") do
    survey = Survey.create({:name => "what's your favorite cocktail?"})
    expect(survey.name()).to(eq("What's your favorite cocktail?"))
  end
end
