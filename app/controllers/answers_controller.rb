class AnswersController < ApplicationController
  def create
    question = Question.find_by(id: params[:question_id])
    @answer = current_user.answers.build(answer_params)
    @answer.question = question
    if @answer.save
      redirect_to question_path(question.id)
    else
      flash[:notice] = "Something went wrong."
      redirect_to question_path(question.id)
    end
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end


