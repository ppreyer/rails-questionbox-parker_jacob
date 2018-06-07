class Api::V1::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authentication, only: [:index, :show]

  def index
    @questions = Question.order(:title).page(params[:page])
    render json: @questions
  end

  def show
    @question = Question.find(params[:id])
    render json: @question
  end

  def new
    if current_user
    @question = Question.new
    else
      redirect_to new_api_v1_session_path, { error: "You must login to create a question" }, status: 401
    end
  end

  def edit
    if current_user
      if current_user.id == @question.user_id
          @question = Question.find(params[:id])
      else
          redirect_to api_v1_question_path, { error: "Only question creator can edit" }, status: 401
      end
    else
      redirect_to new_api_v1_session_path, { error: "Please log in first" }, status: 401
    end
  end

  def create
    @question = Question.new(question_params)
    respond_to do |format|
      if @question.save        
        format.json { render :show, status: :created, location: @question }
      else
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @question = Question.find(params[:id])
    respond_to do |format|
      if @question.update(question_params)
        format.json { render :show, status: :ok, location: @question }
      else
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
      @question = Question.find(params[:id])
      if current_user
        if current_user.id == @question.user_id
          @question.destroy
            respond_to do |format|
            format.json { head :no_content }
          end
        else
            redirect_to @question, { error: "Only post creator can delete" }, status: 401 
        end
      else
        redirect_to new_api_v1_session_path, { error: "Please log in first" }, status: 401
      end
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :content, :user_id, :image)
    end
end
