class Answer < ActiveRecord::Base

  has_many :comments, :as => :commentable
  has_many :votes, :as => :votable
  belongs_to :user
  belongs_to :question

  def self.newest_answer_id
    self.order(:created_at)[0].question_id
  end

  def self.top_voted_answer(question)
    question.answers.select{|answer| answer.count_votes.is_a?(Integer)}.sort{|answer| answer.count_votes}.last
  end


  def count_votes
    votes.map{|vote| vote.value}.reduce(:+)
  end

end
