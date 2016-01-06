module Voting
  def count_votes
    votes.sum(:value)
  end
end