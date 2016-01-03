class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    question = current_user.questions.build(question_params)

    if question.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @comment = Comment.new
  end


private

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
