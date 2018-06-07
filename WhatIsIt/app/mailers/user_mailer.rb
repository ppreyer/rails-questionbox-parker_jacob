class UserMailer < ApplicationMailer
  def answer(question)
    @question = question
    @user = @question.user

    @greeting = "Hi #{@user.username}!" 
    @qurl = question_url(@question.id, host: 'localhost:3000')
    
    mail(
        to: @user.email,
        from: "admin@cartalk.com",
        subject: "You've Received an Answer"
      )
    end
end
