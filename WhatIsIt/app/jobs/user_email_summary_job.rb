class UserEmailSummaryJob < ApplicationJob
  queue_as :default

  def perform
    users = User.all
    
    users.each do |user|
      UserMailer.summary(user).deliver_now 
    end
  end
end
