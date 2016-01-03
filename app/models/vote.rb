class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true
  belongs_to :author, class_name: 'User'
  validates_uniqueness_of :user_id, scope: [:votable_id, :votable_type]
end
