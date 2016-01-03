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
    top = question.answers.select{|answer| answer.count_votes.is_a?(Integer)}.sort{|answer| answer.count_votes}.reverse
    question.answers.each do |answer|
      if top.exclude?(answer)
        top << answer
      end
    end
    if top.delete_if{|answer| answer.id == question.accepted_answer_id}
      top.unshift(question.answers.select{|answer| answer.id == question.accepted_answer_id}.first)
    end
    top.compact
  end

  def count_votes
    votes.map{|vote| vote.value}.reduce(:+)
  end
end
