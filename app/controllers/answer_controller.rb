class AnswerController < ApplicationController::Base
  before_filter :find_answer, :find_question

    def create
      @answer = Answer.new(answer_params)
      if @answer.save
        redirect_to question_path(@question)
      else
        flash[:warning] = "Could not save answerm please try again."
        render :new
      end
    end

    def edit
    end

    def update
      @question = params[:question_id]
      if @answer.update_attributes(params[:answer])
        flash[:success] = "Answer update saved"
        redirect_to question_path(@question)
      else
        flash[:warning] = "Unable to update answer"
        render :edit
      end
    end

    private

    def find_question
      @question = Question.find_by(id: params[:id]) if params[:id]
    end

    def find_answer
      @answer = Answer.find_by(id: params[:id]) if params[:id]
    end

    def answer_params
      params.require(:answer).permit(:body, :question_id).merge(user_id: current_user.id )
    end
end