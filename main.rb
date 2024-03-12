require 'json'
require 'csv'

input_file_path = 'input_json_files/users.json'
file_content = File.read(input_file_path)
parsed_json = JSON.parse(file_content)

CSV.open("output.csv", "wb") do |csv|
  puts JSON.parse(file_content).keys
  # Header row
  csv << ['id', 'email', 'tags', 'profiles.facebook.id', 'profiles.facebook.picture', 'profiles.twitter.id', 'profiles.twitter.picture
  ']

  parsed_json.each do |item|
    csv << [
      item['id'],
      item['email'],
      item['tags'].join('',''),
      item['profiles']['facebook']['id'],
      item['profiles']["facebook"]['picture'],
      item['profiles']['twitter']['id'],
      item['profiles']['twitter']['picture']
    ]
  end
end
