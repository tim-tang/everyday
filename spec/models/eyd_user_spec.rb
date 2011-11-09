require 'spec_helper'

describe EydUser do
  before(:all) do
    @user = Factory.build(:user)
    @user.save
  end

  it "validates user name should be unique" do
    puts @user.errors.inspect
    @user.should be_valid
  end

  it "validates user name should not unique" do
    user = EydUser.new(:id=>2, :name=>'tim.tang')
    user.save
    user.should_not be_valid
  end

  it "validates password confirmation should not be same" do
    user = EydUser.new(:id=>2, :name=>'tim',:password=>'tim.tang', :password_confirmation=>'tim')
    user.save
    puts user.errors.inspect
    user.should_not be_valid
  end

  it "validates password confirmation should be same" do
    user = EydUser.new(:id=>2, :name=>'tim', :password=>'tim.tang', :password_confirmation=>'tim.tang')
    user.save
    puts user.errors.inspect
    user.should be_valid
  end

  it "should authenticate with matching username&password" do
    EydUser.authenticate('tim.tang','tim83tang').should == @user
  end

  it "should authenticate with incorrect username&password" do
    EydUser.authenticate('tim.tang','tim.tang').should be_nil
  end

  after(:all) do
    @user.delete
  end
end
