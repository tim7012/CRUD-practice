namespace :dev do

  task :rebuild => ["db:drop", "db:setup", :fake]


  task :fake => :environment do
    User.delete_all
    Event.delete_all
    Attendee.delete_all

    puts "Creating fake data!"
    user = User.create!(:email => "tim7012@msn.com", :password => "123456")

    50.times do |i|
      e = Event.create(:name => Faker::App.name)
      10.times do |j|
        e.attendees.create( :name => Faker::Name.name)
      end
    end
  end

  task :station => :environment do
    url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=6556e1e8-c908-42d5-b984-b3f7337b139b"
    json_string = RestClient.get(url)
    data = JSON.parse( json_string )

    data["result"]["results"].each do |u|

      existing = Station.find_by_raw_id( u["_id"] )
         if existing
           # update
         else
           Station.create( :raw_id => u["_id"], :name => u["sna"])
           puts "create #{u["sna"]}"
         end
      end
  end

end

# rake dev:station
