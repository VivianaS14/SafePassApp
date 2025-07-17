# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Entry.create!(
  user_id: 1,
  name: 'Github',
  url: 'https://github.com',
  username: 'githubUsername',
  password: 'GithubPassword123'
)

Entry.create!(
  user_id: 1,
  name: 'Dribbble',
  url: 'https://dribbble.com',
  username: 'dribbbleUsername@email.com',
  password: 'dribbblepassword123'
)

Entry.create!(
  user_id: 1,
  name: 'Stack Overflow',
  url: 'https://stackoverflow.com',
  username: 'StackOverflowUsername',
  password: 'StackOverflowpassword123'
)

Entry.create!(
  user_id: 1,
  name: 'Udemy',
  url: 'https://udemy.com',
  username: 'udemyUsername@email.com',
  password: 'udemypassword123'
)

Entry.create!(
  user_id: 1,
  name: 'Google',
  url: 'https://google.com',
  username: 'GoogleUsername@email.com',
  password: 'Googlepassword123'
)

Entry.create!(
  user_id: 1,
  name: 'Facebook',
  url: 'https://facebook.com',
  username: 'FacebookUsername',
  password: 'Facebookpassword123'
)

Entry.create!(
  user_id: 1,
  name: 'X',
  url: 'https://x.com',
  username: 'XUsername@email.com',
  password: 'Xpassword123'
)

Entry.create!(
  user_id: 1,
  name: 'Amazon',
  url: 'https://Amazon.com',
  username: 'AmazonUsername@email.com',
  password: 'AmazonPassword123'
)
