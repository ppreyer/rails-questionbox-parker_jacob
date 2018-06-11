class ChangeImageToImageUrl < ActiveRecord::Migration[5.2]
  def change
    rename_column :answers, :image, :image_url
    rename_column :questions, :image, :image_url
  end
end
