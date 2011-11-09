require 'spec_helper'

describe EydLoginController do
  render_views

  describe "showing up the login screen" do
    it "should start with /login" do
      get 'login'
      response.should be_success
    end
  end

  describe "login into admin" do
    before(:all) do
      @user = Factory.build(:user)
      @user.save
    end

    it "should login success" do
      EydUser.stubs(:authenticate).returns(@user)
      post 'authentication'
      flash[:notice].should == "User #{@user.name} login success"
      response.should redirect_to(avatar_index_path)
    end

    it "should login failure" do
      EydUser.stubs(:authenticate).returns(nil)
      post 'authentication'
      response.should redirect_to(login_path)
    end

    after(:all) do
      @user.delete
    end
  end

  describe "logout admin" do
    it "should logout success" do
      post 'destroy'
      response.should redirect_to(login_path)
    end
  end

end
