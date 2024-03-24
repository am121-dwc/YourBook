puts 'books ...'
50.times do
    book = Book.create!(
    title: Faker::Lorem.word,
    introduction: Faker::Lorem.paragraph(sentence_count: 2),
    user_id: 1
  )
end