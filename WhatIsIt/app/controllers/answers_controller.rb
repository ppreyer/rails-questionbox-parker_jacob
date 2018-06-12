class AnswersController < ApplicationController
  skip_before_action :verify_authentication

  def index
    @answers = Answer.all
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def new
    @question = Question.find(params[:question_id])
    if current_user
        @answer = Answer.new
    else
        redirect_to question_path(@question), alert: "You must be logged in to comment."
    end
  end

  def edit
    @answer = Answer.find(params[:id])
    if current_user
      if current_user.id == @answer.user_id
          @question = Question.find(params[:id])
      else
          redirect_to question_path, alert: 'Only answer creator can edit.'
      end
    else
      redirect_to new_session_path, alert: "Please log in first."
    end
  end

  def create
    @question = Question.find(params[:id])
    @user = User.find_by(params[:user_id])
    respond_to do |format|
      if @answer.save!
        send_answer_email(@user)        
        format.html { redirect_to question_path, notice: 'answer was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to question_path, notice: 'answer was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if current_user
      if current_user.id == @answer.user_id
        @answer.destroy
          respond_to do |format|
          format.html { redirect_to questions_path, alert: 'answer was successfully destroyed.' }
        end
      else
          redirect_to @answer, alert: 'Only post creator can delete.'
      end
    else
      redirect_to new_session_path, alert: 'Please log in first'
    end
  end

  private

    def answer_params
      params.require(:answer).permit(:content, :user_id, :question_id, :image_url, :title)
    end

    def send_answer_email(user)
      UserMailer.answer(user).deliver_now
    end
end
