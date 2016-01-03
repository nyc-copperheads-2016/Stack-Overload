class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end
  def create
    if defined?(params[comment.id])
      vote = current_user.votes.build(vote_params)
      vote.voteable_id = comment.id
      vote.votable_type = "Comment"
    elsif define(params[question.id])
      vote = current_user.votes.build(vote_params)
      vote.votable_type = "Question"
      comment.voteable_id = question.id
    else
      vote = current_user.votes.build(vote_params)
      vote.votable_type = "Answer"
      comment.voteable_id = answer.id
    end

    if vote.save
      redirect_to question_path(question.id)
    else
      flash.now[:warning] = 'vote failed'
    end

  end

  private

  def vote_params
    params.require(:vote).permit(:value)
  end
end
