class Api::V1::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authentication

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = Question.new(question_params)
    respond_to do |format|
      if @question.save        
        format.html { redirect_to api_v1_questions_path, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @question = Question.find(params[:id])
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to api_v1_question_path, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
      @question = Question.find(params[:id])
      if current_user.id == @question.user_id
        @question.destroy
          respond_to do |format|
          format.html { redirect_to api_v1_questions_path, alert: 'Question was successfully destroyed.' }
          format.json { head :no_content }
        end
      else
          redirect_to @question, alert: 'Only post creator can delete.'
      end
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :content, :user_id)
    end
end
