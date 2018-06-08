# == Schema Information
#
# Table name: questions
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Question < ApplicationRecord
  has_many :answers
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true
  validates :content, presence: true
end
