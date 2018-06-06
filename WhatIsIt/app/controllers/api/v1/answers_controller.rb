class Api::V1::AnswersController < ApplicationController
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
        redirect_to api_v1_question_path(@question), alert: "You must be logged in to comment."
    end
  end

  def edit
    @answer = Answer.find(params[:id])
    if current_user
      if current_user.id == @answer.user_id
          @question = Question.find(params[:id])
      else
          redirect_to api_v1_question_path, alert: 'Only answer creator can edit.'
      end
    else
      redirect_to new_api_v1_session_path, alert: "Please log in first."
    end
  end

  def create
    @answer = Answer.new(answer_params)
    respond_to do |format|
      if @answer.save!        
        format.html { redirect_to api_v1_question_path, notice: 'answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new }
        format.json { render json: @answers.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to api_v1_question_path, notice: 'answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if current_user
      if current_user.id == @answer.user_id
        @answer.destroy
          respond_to do |format|
          format.html { redirect_to api_v1_questions_path, alert: 'answer was successfully destroyed.' }
          format.json { head :no_content }
        end
      else
          redirect_to @answer, alert: 'Only post creator can delete.'
      end
    else
      redirect_to new_api_v1_session_path, alert: 'Please log in first'
    end
  end

  private

    def answer_params
      params.require(:answer).permit(:content, :user_id, :question_id)
    end
end
