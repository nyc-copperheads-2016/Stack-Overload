class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes
  validates :username, uniqueness: true, presence: true, length: {minimum: 3}
  validates :password_digest, presence: true, length: {minimum: 6}
  validates_confirmation_of :password, :confirm => :password_confirmation

  def password_confirmation_matches
    unless password_confirmation == self.password
      errors.add(:password_confirmation, "must match password")
    end
  end

  has_secure_password
end
