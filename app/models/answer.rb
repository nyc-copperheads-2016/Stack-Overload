class Answer < ActiveRecord::Base
  has_many :comments, :as => :commentable
  has_many :votes, :as => :votable
  belongs_to :user
  belongs_to :question

  def self.newest_answer_id
    self.order(:created_at)[0].question_id
  end
end
