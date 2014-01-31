require 'spec_helper'

describe Login do

  describe "auth!" do
    it "raises an exception with invalid params" do
      -> { Login.auth!(nil) }.should raise_error(RuntimeError, 'invalid facebook login')
    end
  end
  describe "auth" do
  	it "brings infomative symbol if nil" do
  	  Login.new.auth.should == :auth_nil
  	end
  	it "bring a hash" do
  	  Login.new(auth_s: '{}').auth.should be_a Hash
  	end
  end

  describe "with_access_token!" do
    before do
      @fb_me_mocked = {"id"     => "12345",
                       "name"   => "Sarah Example",
                       "gender" => "female"
                       }
      Koala::Facebook::API.any_instance.stub(get_object: @fb_me_mocked)
      Login.any_instance.stub(:update_with_facebook_data!)
    end
    describe "with invalid args" do
      it "with a blank value" do
        Koala::Facebook::API.any_instance.should_not_receive(:get_object)
        Login.with_access_token!('', nil).should == :invalid
      end
    end
    describe "with valid args" do
      
      it "a fb_token" do
        Koala::Facebook::API.any_instance.should_receive(:get_object)
                                         .with('me')
        Login.any_instance.should_receive(:update_with_facebook_data!)
                          .with(@fb_me_mocked['name'], @fb_me_mocked['gender'], 'abc', anything())
        
        Login.with_access_token!('abc', nil).should be_a Login
      end
      it "an fb_expires" do
        dt = 1.day.from_now
        -> {
          Login.with_access_token!('abc', dt)
        }.should_not raise_error
        -> {
          Login.with_access_token!('def', dt.to_i)
        }.should_not raise_error
      end
    end
  end
  describe "update_with_facebook_data!" do
    
    it "works" do
      User.any_instance.should_receive(:store_fb_friends!)
      
      login = Login.new(provider: 'facebook', uid: '12345')
      dt = DateTime.tomorrow
      -> {
        login.update_with_facebook_data!('name', 'gender', 'token', dt)
      }.should change(User, :count)

      login.user.should be_persisted
      login.should be_persisted

      User.last.fb_expires_at.to_date.should == dt.to_date
    end

  end

end
