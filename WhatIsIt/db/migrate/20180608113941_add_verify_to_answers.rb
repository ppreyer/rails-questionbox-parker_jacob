class AddVerifyToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :verify_answer, :boolean, default: false
  end
end
