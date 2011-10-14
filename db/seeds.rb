# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#   rake db:seed
EydUser.create(:name=>"tim", :password=>"tim", :password_confirmation=>"tim")
EydConstant.create(:id=>1,:category => 'Tim technic blog', :user_id=>"1")
EydConstant.create(:id=>2,:category => 'YoYo blog', :user_id=>"2")

EydComment.create(:id=>1, :parent_id => 0, :blog_id=>3, :book_id=>5, :name=>"tim.tang", :email=>"tang.jilong@gmail.com", :content=>"testing for comment!", :is_guestbook=>false)
EydComment.create(:id=>2, :parent_id => 0, :blog_id=>3, :book_id=>5, :name=>"tim.tang", :email=>"tang.jilong@gmail.com", :content=>"testing for comment!", :is_guestbook=>false)
EydComment.create(:id=>3, :parent_id => 0, :blog_id=>3, :book_id=>5, :name=>"tim.tang", :email=>"tang.jilong@gmail.com", :content=>"testing for comment!", :is_guestbook=>false)
EydComment.create(:id=>4, :parent_id => 0, :blog_id=>3, :book_id=>5, :name=>"tim.tang", :email=>"tang.jilong@gmail.com", :content=>"testing for comment!", :is_guestbook=>false)
EydComment.create(:id=>5, :parent_id => 0, :blog_id=>3, :book_id=>5, :name=>"tim.tang", :email=>"tang.jilong@gmail.com", :content=>"testing for comment!", :is_guestbook=>false)
EydComment.create(:id=>6, :parent_id => 0, :blog_id=>3, :book_id=>5, :name=>"tim.tang", :email=>"tang.jilong@gmail.com", :content=>"testing for comment!", :is_guestbook=>false)
EydComment.create(:id=>7, :parent_id => 0, :blog_id=>3, :book_id=>5, :name=>"tim.tang", :email=>"tang.jilong@gmail.com", :content=>"testing for comment!", :is_guestbook=>false)
EydComment.create(:id=>8, :parent_id => 0, :blog_id=>3, :book_id=>5, :name=>"tim.tang", :email=>"tang.jilong@gmail.com", :content=>"testing for comment!", :is_guestbook=>false)
EydComment.create(:id=>9, :parent_id => 0, :blog_id=>3, :book_id=>5, :name=>"tim.tang", :email=>"tang.jilong@gmail.com", :content=>"testing for comment!", :is_guestbook=>false)
EydComment.create(:id=>10, :parent_id => 0, :blog_id=>3, :book_id=>5, :name=>"tim.tang", :email=>"tang.jilong@gmail.com", :content=>"testing for comment!", :is_guestbook=>false)
EydComment.create(:id=>11, :parent_id => 0, :blog_id=>3, :book_id=>5, :name=>"tim.tang", :email=>"tang.jilong@gmail.com", :content=>"testing for comment!", :is_guestbook=>false)
