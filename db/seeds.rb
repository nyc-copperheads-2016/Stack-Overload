u = User.create!(username: "admin", password_digest: "123456")

10.times do 
  q = Question.create!(title: Faker::Hipster.sentences(8), body: Faker::Hipster.sentences(10, true, 5), user_id: u)
  6.times do  
    a = Answer.create!(title: Faker::Hipster.sentences(8), body: Faker::Hipster.sentences(10, true, 5), user_id: u, question_id: q)
    # 3.times do 
    #   c = Comment.create! ()  #need to do
  end
end