# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#   rake db:seed
EydUser.create(:name=>"lisa.dong", :password=>"pas$word123", :password_confirmation=>"pas$word123")
EydUser.create(:name=>"tim.tang", :password=>"tim83tang", :password_confirmation=>"tim83tang")
