class Survey < ActiveRecord::Base
  has_many(:questions)
  before_save(:capitalize_name)

private

  define_method(:capitalize_name) do
    self.name=(name().capitalize())
  end
end
