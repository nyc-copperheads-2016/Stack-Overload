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

  # This should probably be count_votes and covered by the voting module
  # I can't see that you call this one anywhere
  def vote_count
    votes.sum(:value)
  end

  has_secure_password
end
