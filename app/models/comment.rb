class Comment < ActiveRecord::Base
  include Voting
  has_many :votes, :as => :votable
  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
