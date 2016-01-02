u = User.create!(username: "christopher", password_digest: "123456")

10.times do 
  q = Question.create!(title: Faker::Hipster.sentence(8), body: Faker::Hipster.sentence(10, true, 5), user_id: u.id)
  6.times do  
    a = Answer.create!(body: Faker::Hipster.sentence(10, true, 5), user_id: u.id, question_id: q.id)
    # 3.times do 
    #   c = Comment.create! ()  #need to do
  end
end