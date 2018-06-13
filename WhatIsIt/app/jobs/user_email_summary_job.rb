class UserEmailSummaryJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    

    UserMailer.summary(user).deliver_now 
  end
end
