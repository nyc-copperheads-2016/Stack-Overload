class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes
  has_many :votes_for, class_name: "Vote", foreign_key: "author_id"
  validates :username, uniqueness: true, presence: true, length: {minimum: 3}
  validates :password, presence: true, length: {minimum: 6}
  validates_confirmation_of :password, :confirm => :password_confirmation

  def password_confirmation_matches
    unless password_confirmation == self.password
      errors.add(:password_confirmation, "must match password")
    end
  end

  def vote_count
    votes_for.map{|vote| vote.value}.reduce(:+)
  end



  has_secure_password
end
