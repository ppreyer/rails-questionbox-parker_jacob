class AddIDsToModels < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :user_id, :integer
    add_column :answers, :user_id, :integer
    add_column :answers, :question_id, :integer
  end
end
