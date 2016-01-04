class QuestionsController < ApplicationController
  before_action :ensure_logged_in, only:[:new, :create, :update]
  def index
    @questions = Question.all
  end

  def trending
    @questions = Question.trending_questions
    render 'index'
  end

  def voted
    @questions = Question.top_voted_questions
    render 'index'
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
    @answers = Answer.top_voted_answer(@question)
    @answer = Answer.new
    @comment = Comment.new
    @vote = Vote.new
  end

  def update
    question = Question.find(params[:id])
    question.update_attributes(accepted_answer_id: params[:chosen_answer_id])
    redirect_to question_path(question)
  end



private

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
