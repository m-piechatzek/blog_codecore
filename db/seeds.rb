# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
tags = ["complaining", "silly", "cats", "doge", "super serious"]

tags.each do |tag|
  Tag.create(name: tag)
end

print Cowsay::say("Created #{tags.length} tags!")
