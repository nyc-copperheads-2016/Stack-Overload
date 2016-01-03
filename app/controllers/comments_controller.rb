class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    if defined?(params[answer.id])
      comment = current_user.comments.build(comment_params)
      comment.commentable_id = answer.id
      comment.commentable_type = "Answer"
    else
      comment = current_user.comments.build(comment_params)
      comment.commentable_type = "Question"
      comment.commentable_id = question.id
    end

    if comment.save
      redirect_to question_path(question.id)  #have to pass in question.id as a local in the question show page when the comment is to an  answer
    else
      render 'new'
    end
  end

private

  def comment_params
    params.require(:comment).permit(:body)
  end

end



