# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"
require "json"

url = "https://tmdb.lewagon.com/movie/top_rated"
SIZE_500 = "w500"
SIZE_ORIGINAL = "original"
IMAGE_PREFIX = "https://image.tmdb.org/t/p/"


response = URI.open(url).read
data = JSON.parse(response)
puts "Movie count: #{data["results"].length}"

movies = data["results"]
puts "--" * 20
puts "CLEARING RECORDS in Movies DB..."
Movie.destroy_all

puts "RECORDS FOUND: #{Movie.count}"
puts "==" * 20

puts "Seeding DB with movies..."

movies.each_with_index do |m, index|
  # puts "~~~~ MOVIE ##{index + 1} ~~~~"
  # puts "Title: #{m["title"]}"
  # puts "Overview: #{m["overview"][0...40]}…"
  # puts "Image: #{IMAGE_PREFIX}#{SIZE_500}#{m["poster_path"]}"
  # puts "~~" * 12

  Movie.create!(
    title: m["title"],
    overview: m["overview"],
    poster_url: "#{IMAGE_PREFIX}#{SIZE_500}#{m["poster_path"]}",
    rating: m["vote_average"]
    )
end
puts "----" * 20
puts "#{Movie.count} records created!"

records = Movie.all

records.each do |r|
  puts "#{r.id}: #{r.title}, #{r.overview[0..20]}… #{r.poster_url}, R:#{r.rating}"
end

puts ("====== DONE =======")