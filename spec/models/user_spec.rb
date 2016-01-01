require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_length_of(:username).is_at_least(3) } 
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password_digest).is_at_least(6) } 
  it { should have_many(:questions) }
  it { should have_many(:answers) }
  it { should have_many(:comments) }
  it { should have_many(:votes) }

  it "is invalid without a username" do
    user = User.new(username: nil, password_digest: "password")
    expect(user).not_to be_valid
  end

  it "is invalid without a password" do 
    user = User.new(username: "username", password_digest: nil)
    expect(user).not_to be_valid
  end
end
