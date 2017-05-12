require 'open-uri'
require 'csv'

namespace :read_csv do
  desc "TODO"
  task create_records: :environment do
    url = "https://s3-us-west-2.amazonaws.com/hyouka/static_files/memberdata.csv"
    CSV.new(open(url), :headers => true).each do |file|
      name = file['Name']
      fixed_name = name.force_encoding('iso-8859-1').force_encoding('utf-8')
      unless Person.find_by(email: file['Email'])
        person = Person.create(name: fixed_name, email: file['Email'], gender: file['Gender'])
        person.save
        puts person.name
      end
    end
    p Person.all.count
  end

end
