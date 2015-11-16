# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Post.create([{text: 'Hello I am a friendly post', content_type: 'verified_content'},
             {text: 'Arrgh this is a spam post', content_type: 'spam'}
             ])
