class AddImageToQuestionAndAnswerTable < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :image, :string
    add_column :answers, :image, :string
  end
end
