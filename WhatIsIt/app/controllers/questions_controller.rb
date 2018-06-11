class QuestionsController < ApplicationController
    before_action :set_question, only: [:show, :edit, :update, :destroy]
    skip_before_action :verify_authentication

    def index
        @questions = Question.order(:title).page(params[:page])
    end

    def show
        @question = Question.find(params[:id])
    end

    def new
        if current_user
        @question = Question.new
        else
          redirect_to session_path, alert: 'You must login to create a question'
        end
    end

    def edit
        if current_user
          if current_user.id == @question.user_id
              @question = Question.find(params[:id])
          else
              redirect_to question_path, alert: 'Only question creator can edit.'
          end
        else
          redirect_to new_session_path, alert: "Please log in first."
        end
    end

    def create
        @question = Question.new(question_params)
        respond_to do |format|
          if @question.save        
            format.html { redirect_to questions_path, notice: 'Question was successfully created.' }
          else
            format.html { render :new }
          end
        end
    end

    def update
        @question = Question.find(params[:id])
        respond_to do |format|
          if @question.update(question_params)
            format.html { redirect_to question_path, notice: 'Question was successfully updated.' }
          else
            format.html { render :edit }
          end
        end
    end

    def destroy
        @question = Question.find(params[:id])
        if current_user
          if current_user.id == @question.user_id
            @question.destroy
              respond_to do |format|
              format.html { redirect_to questions_path, alert: 'Question was successfully destroyed.' }
            end
          else
              redirect_to @question, alert: 'Only post creator can delete.'
          end
        else
          redirect_to new_session_path, alert: 'Please log in first'
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
