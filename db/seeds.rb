# frozen_string_literal: true

# User seed data
john = FactoryBot.create(:user, email: "john@gmail.com")
george = FactoryBot.create(:user, email: "george@gmail.com")

# Vertical seed data
health_vert = FactoryBot.create(:vertical, :valid, name: "Health & Fitness")
biz_vert = FactoryBot.create(:vertical, :valid, name: "Business")
music_vert = FactoryBot.create(:vertical, :valid, name: "Music")

# Category seed data
booty = FactoryBot.create(:category, :valid, name: "Booty & Abs", vertical_id: health_vert.id)
full_body = FactoryBot.create(:category, :valid, name: "Full Body", vertical_id: health_vert.id)

advertising = FactoryBot.create(:category, :valid, name: "Advertising", vertical_id: biz_vert.id)
writing = FactoryBot.create(:category, :valid, name: "Writing", vertical_id: biz_vert.id)

singing = FactoryBot.create(:category, :valid, name: "Singing", vertical_id: music_vert.id)
fundamentals = FactoryBot.create(:category, :valid, name: "Music Fundamentals", vertical_id: music_vert.id)

# Course seed data
FactoryBot.create(:course, :valid, name: "Loose the Gutt, keep the Butt", author: "Anowa", category_id: booty.id)
FactoryBot.create(:course, :valid, name: "BrittneBabe Fitness Transformation", author: "Brittnebabe", category_id: booty.id)

FactoryBot.create(:course, :valid, name: "BTX: Body Transformation Extreme", author: "Barstarzz", category_id: full_body.id)

FactoryBot.create(:course, :valid, name: "Facebook Funnel Marketing", author: "Russell Brunson", category_id: advertising.id)
FactoryBot.create(:course, :valid, name: "Build a Wild Audience", author: "Tim Nilson", category_id: advertising.id)

FactoryBot.create(:course, :valid, name: "Editorial Writing Secrets", author: "J. K. Rowling", category_id: writing.id)
FactoryBot.create(:course, :valid, name: "Scientific Writing", author: "Stephen Hawking", category_id: writing.id)

FactoryBot.create(:course, :valid, name: "Vocal Training 101", author: "Linkin Park", category_id: singing.id)
FactoryBot.create(:course, :valid, name: "Music Performance for Beginners", author: "Lady Gaga", category_id: singing.id)

FactoryBot.create(:course, :valid, name: "Learn the Piano", author: "Lang Lang", category_id: fundamentals.id)
FactoryBot.create(:course, :valid, name: "Become a guitar hero", author: "Jimmy Page", category_id: fundamentals.id)
