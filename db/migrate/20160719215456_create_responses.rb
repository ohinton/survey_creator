class CreateResponses < ActiveRecord::Migration
  def change
    create_table(:responses) do |t|
      t.column(:answer, :string)
      t.column(:question_id, :int)

      t.timestamps()
    end
  end
end
