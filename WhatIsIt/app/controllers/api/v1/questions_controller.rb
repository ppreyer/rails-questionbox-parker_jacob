class Api::V1::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authentication, only: [:index, :show]

  def index
    @questions = Question.order(:created_at).reverse_order.page(params[:page])
    @questions = @questions.each do |question|
      @user = User.find(question.user_id)
      @question_username = @user.username
    end
    if @questions
      render "api/v1/questions/index.json" 
    else
      render json: @questions.errors, status: 400
    end
  end

  def show
    @question = Question.find(params[:id])
    @user = User.find(@question.user_id)
    @question_username = @user.username
    @answer_username = @user.username
    @answers = @question.answers
    if @question
      render "api/v1/questions/show.json"
    else
      render json: @question.errors, status: 400
    end
  end

  def new
    if current_user
      @question = Question.new
      render json: @question, status: 200
    else
      render json: @question.errors, status: 401
    end
  end

  def edit
    if current_user
      if current_user.id == @question.user_id
          @question = Question.find(params[:id])
          render json: @question, status: 200
      else
        render json: { error: "Only question user can edit." }, status: :unauthorized
      end
    else
      render json: { error: "Please log in first" }, status: 401
    end
  end

  def create
    if current_user 
      @question = Question.new(question_params)
      respond_to do |format|
        if @question.save        
          format.json { render :show, status: :created, location: @question }
        else
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    else
      render json: { error: "Please log in first" }, status: 401
    end

  end

  def update
    @question = Question.find(params[:id])
    if current_user
      if current_user.id == @question.user_id
        if @question.update(question_params)
          respond_to do |format|
            format.json { render :show, status: :ok, location: @question }
          else
            format.json { render json: @question.errors, status: :unprocessable_entity }
          end
        end
      else
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    else
      format.json { render json: @question.errors, status: :unprocessable_entity }
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
          render json: { error: "Only question user can delete." }, status: :unauthorized
        end
      else
        render json: { error: "Please log in first" }, status: 401
      end
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :content, :user_id, :image_url)
    end
end
