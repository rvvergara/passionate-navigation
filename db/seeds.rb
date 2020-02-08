# frozen_string_literal: true

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
