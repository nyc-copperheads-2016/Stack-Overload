class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes
  validates :username, uniqueness: true, presence: true, length: {minimum: 3}
  validates :password_digest, presence: true, length: {minimum: 6}
end
