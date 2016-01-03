class Comment < ActiveRecord::Base
  has_many :votes, :as => :votable
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  def self.vote_count
    self.votes.count
  end
end
