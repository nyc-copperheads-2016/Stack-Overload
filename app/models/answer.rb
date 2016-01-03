class Answer < ActiveRecord::Base

  has_many :comments, :as => :commentable
  has_many :votes, :as => :votable
  belongs_to :user
  belongs_to :question

  def self.newest_answer_id
    self.order(:created_at)[0].question_id
  end

  def self.newest_answers
    array = []
    Answer.order(:updated_at).group_by{|answer| answer.question_id}.each do |group|
      array << group[1][0]
    end
    array
  end

  def self.top_voted_answer(question)
    question.answers.select{|answer| answer.count_votes.is_a?(Integer)}.sort{|answer| answer.count_votes}.last
  end

  def count_votes
    votes.map{|vote| vote.value}.reduce(:+)
  end
end
