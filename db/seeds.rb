u = User.create!(username: "christopher", password_digest: "123456")
10.times do 
  q = Question.create!(title: Faker::Hipster.sentence(8), body: Faker::Hipster.sentence(10, true, 5), user_id: u.id)
  3.times do 
      c = Comment.create!(body: Faker::Hipster.sentence(10, true, 5), user_id: u.id, commentable_id: q.id, commentable_type: "Question") 
  end 
  6.times do  
    a = Answer.create!(body: Faker::Hipster.sentence(10, true, 5), user_id: u.id, question_id: q.id)
    3.times do 
      c = Comment.create!(body: Faker::Hipster.sentence(10, true, 5), user_id: u.id, commentable_id: a.id, commentable_type: "Answer")  
    end
  end
end

