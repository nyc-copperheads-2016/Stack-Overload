class VotesController < ApplicationController
  before_action :ensure_logged_in, only:[:create]

  def new
    @vote = Vote.new
  end
  def create
    if (params.has_key?(:comment_id))
      vote = current_user.votes.build(vote_params)
      vote.votable_type = "Comment"
      vote.votable_id = params[:comment_id]
      comment = Comment.find_by(id: params[:comment_id])
      vote.author_id = comment.user.id
      if comment.commentable_type == "Question"
        params[:question_id] = comment.commentable.id

      else
        params[:question_id] = comment.commentable.question.id
      end
    elsif (params.has_key?(:question_id))
      vote = current_user.votes.build(vote_params)
      vote.votable_type = "Question"
      vote.votable_id = params[:question_id]
      vote.author_id = Question.find_by(id: params[:question_id]).user.id
    else
      vote = current_user.votes.build(vote_params)
      vote.votable_type = "Answer"
      vote.votable_id = params[:answer_id]
      params[:question_id] = Answer.find_by(id: params[:answer_id]).question.id
      vote.author_id = Answer.find_by(id: params[:answer_id]).user.id
    end

    if vote.save
      redirect_to question_path(params[:question_id])
    else
      flash.now[:warning] = 'vote failed'
    end

  end

  private

  def vote_params
    params.require(:vote).permit(:value)
  end
end
