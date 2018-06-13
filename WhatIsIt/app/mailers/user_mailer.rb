class UserMailer < ApplicationMailer
  default from: 'admin@whatitis.com'
  
  def summary(user)
    @user = user
    @question = user.questions.where('created_at >= ?', 1.week.ago).count
    @question_list = user.questions.where('created_at >= ?', 1.week.ago)
    @answer = user.answers.where('created_at >= ?', 1.week.ago).count
    @answer_list = user.answers.where('created_at >= ?', 1.week.ago)
    mail(
      to: @user.email
    )   
  end
end
