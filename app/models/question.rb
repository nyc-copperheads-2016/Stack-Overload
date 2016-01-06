class Question < ActiveRecord::Base
  include Voting
  belongs_to :user
  has_many :answers
  has_many :comments, :as => :commentable
  has_many :votes, :as => :votable

  def find_accepted_answer
    #maybe return nil rather than throwing error here
    self.answers.find_by(id: accepted_answer_id)
  end

  def self.most_recent_questions
    self.order(created_at: :desc).reverse
  end

  def self.trending_questions(limit=20)
    joins(:answers)
    .where('answers.created_at = (select max(created_at) from answers where question_id = questions.id)')
    .order('answers.created_at desc')
    .limit(limit)
  end

  def self.top_voted_questions
    joins("left join votes on votes.votable_id = questions.id \
            and votes.votable_type = 'Question'")
    .group('questions.id').order('sum(votes.value) desc')
  end

  private

  def self.questions_sorted_by_most_votes
    joins(:votes).group('questions.id').order('count(votes.votable_id) desc')
  end

  def self.questions_with_no_votes
    includes(:votes).where(votes: { :id => nil })
  end

end


# Users should be able to see questions sorted three ways: highest-voted, most recent, and "trending."
