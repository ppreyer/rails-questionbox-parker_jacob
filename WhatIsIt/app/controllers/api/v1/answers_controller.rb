class Api::V1::AnswersController < ApplicationController
  skip_before_action :verify_authentication

  def index
    @answers = Answer.all
    if @answers
      render json: @answers
    else
      render json: @answers.errors, status: 400
    end
  end

  def show
    @answer = Answer.find(params[:id])
    render json: @answer
  end

  def new
    @question = Question.find(params[:question_id])
    if current_user
        @answer = Answer.new
    else
        render json: { error: "You must login to create a question" }, status: 401
    end
  end

  def edit
    @answer = Answer.find(params[:id])
    if current_user
      if current_user.id == @answer.user_id
          @question = Question.find(params[:id])
      else
          render json: { error: "Only question creator can edit" }, status: 401
      end
    else
      render json: { error: "You must login to create a question" }, status: 401
    end
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save   
      render json: @answer
    else
      respond_to do |format|   
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    respond_to do |format|
      if @answer.update(answer_params)
        format.json { render :show, status: :ok, location: @answer }
      else
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
          format.json { head :no_content }
        end
      else
          render json: { error: "Only post creator can delete." }, status: 401
      end
    else
      render json: { error: "You must login to create a question" }, status: 401
    end
  end

  private

    def answer_params
      params.require(:answer).permit(:content, :user_id, :question_id, :verify_answer, :username)
    end

    def send_answer_email(user)
      UserMailer.answer(user).deliver_now
    end
end
