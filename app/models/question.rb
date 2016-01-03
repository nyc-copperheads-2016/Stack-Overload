class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :comments, :as => :commentable
  has_many :votes, :as => :votable

  def find_accepted_answer
    self.answers.find(accepted_answer_id)
  end

  def most_recent_questions
    self.order(:created_at)
  end

  def trending_question
    Question.find(Answer.newest_answer_id)
  end


  def count_votes
    votes.map{|vote| vote.value}.reduce(:+)
  end
end


# Users should be able to see questions sorted three ways: highest-voted, most recent, and "trending."
