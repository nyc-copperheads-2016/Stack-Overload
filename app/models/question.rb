class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :comments, :as => :commentable
  has_many :votes, :as => :votable

  def find_accepted_answer
    self.answers.find(accepted_answer_id)
  end

  def self.most_recent_questions
    self.order(:created_at).reverse
  end

  def self.trending_questions
    Answer.newest_answers.map{|answer| answer.question}
  end

  def self.top_voted_questions
    Question.questions_sorted_by_most_votes + Question.questions_with_no_votes
  end

  def count_votes
    votes.map{|vote| vote.value}.reduce(:+)
  end

  private

  def self.questions_sorted_by_most_votes
    all.select{|question| question.count_votes.is_a?(Integer)}.sort_by{|question| question.count_votes}.reverse
  end

  def self.questions_with_no_votes
    all.select{|question| question.count_votes == nil}
  end

end


# Users should be able to see questions sorted three ways: highest-voted, most recent, and "trending."
