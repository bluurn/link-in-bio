require "faker"

# Community
bryght = Community.find_or_create_by!(slug: "bryght") do |c|
  c.name = "Bryght Community"
end

# Catalog — 120 items, 40 per kind
prices = [ 0, 0, 9.99, 19.99, 29.99, 49.99 ]

event_formats  = %w[Summit Workshop Bootcamp Masterclass Meetup Symposium Retreat Hackathon]
playlist_moods = [ "Best of", "Intro to", "Deep Cuts:", "Essentials:", "Hidden Gems:", "Starting with", "The Making of" ]

Content.kinds.each_key do |kind|
  40.times do |i|
    title = case kind
    when "course"   then Faker::Educator.course
    when "event"    then "#{Faker::Company.buzzword.capitalize} #{event_formats.sample}"
    when "playlist" then "#{playlist_moods.sample} #{Faker::Music.genre}"
    end
    Content.find_or_create_by!(title: title) do |c|
      c.creator         = Faker::Name.name
      c.kind            = kind
      c.description     = Faker::Lorem.paragraphs(number: 16, supplemental: true).join("\n\n")
      c.price           = prices.sample
      c.url             = Faker::Internet.url(host: "example.com")
      c.cover_image_url = "https://picsum.photos/seed/#{kind}#{i}/400/225"
    end
  end
end

# Pre-select 2 of each type for the demo
Content.kinds.each_key do |kind|
  Content.where(kind: kind).take(2).each do |content|
    bryght.selections.find_or_create_by!(content: content)
  end
end

puts "Seeded: 1 community, #{Content.count} contents, #{bryght.selections.count} selections"
