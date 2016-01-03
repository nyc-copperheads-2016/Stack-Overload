class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :comments, :as => :commentable
  has_many :votes, :as => :votes

  def find_accepted_answer
    self.answers.find(accepted_answer_id)
  end

end
