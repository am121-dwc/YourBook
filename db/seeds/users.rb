puts 'users ...'
20.times do
  user = User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    introduction: Faker::Lorem.paragraph(sentence_count: 2),
    password: 'aaaaaa',
    password_confirmation: 'aaaaaa'
  )
end