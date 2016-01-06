class Answer < ActiveRecord::Base
  include Voting

  has_many :comments, :as => :commentable
  has_many :votes, :as => :votable
  belongs_to :user
  belongs_to :question

  def self.newest_answers
    where('answers.updated_at = (select max(updated_at) from answers a where a.question_id = answers.question_id)')
  end

  def self.top_voted_answer(question)
    joins(:votes).where(question:question).group('answers.id').order('sum(votes.value) desc').first
  end
end
