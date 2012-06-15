require 'spec_helper'

describe HomeController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_redirect
      #pending "this is an action for logical decisions"
    end
  end

  describe "GET 'guest'" do
    it "returns http success if not logged in" do
      get 'guest'
      response.should be_success
    end
    it "denies access if logged in" do
      session[:user_id] = Fabricate(:user).id
      get 'guest'
      response.should redirect_to(denied_path)
    end
  end

  describe "GET 'user'" do
    it "returns http success if in role" do
      session[:user_id] = Fabricate(:user).id
      Fabricate(:school)
      get 'user'
      response.should be_success
    end
    it "denies access not in role" do
      session[:user_id] = Fabricate(:user, roles_s: 'student').id
      get 'user'
      response.should redirect_to(denied_path)
    end
  end

  describe "POST 'user'" do
    it "should create a request" do
      current_user = Fabricate(:user)

      session[:user_id] = current_user.id

      expect {
        post 'user_create_school_request', {
          format: 'js',
          school_user_request: {
            school_id: Fabricate(:school).id,
            email: "#{Faker::Internet.user_name}@uncc.edu"
          }
        }
      }.to change(current_user.school_user_requests, :count).by(1)
    end
    it "denies access not in role" do
      session[:user_id] = Fabricate(:user, roles_s: 'student').id
      get 'user'
      response.should redirect_to(denied_path)
    end
  end

  describe "GET 'user_school'" do
    it "creates a new school_user" do
      school_user_request = Fabricate(:school_user_request)
      expect {
        get "user_school", {confirmation_token: school_user_request.confirmation_token}
      }.to change(school_user_request.school.school_users, :count).by(1)
    end
    it "destroys that confirmation_token" do
      school_user_request = Fabricate(:school_user_request)
      expect {
        get "user_school", {confirmation_token: school_user_request.confirmation_token}
      }.to change(SchoolUserRequest, :count).by(-1)
    end
    it "redirects_to home_student_path" do
      school_user_request = Fabricate(:school_user_request)
      get "user_school", {confirmation_token: school_user_request.confirmation_token}
      response.should redirect_to(home_student_path)
    end
    it "logs in the user" do
      school_user_request = Fabricate(:school_user_request)
      session[:user_id].should be_nil
      get "user_school", {confirmation_token: school_user_request.confirmation_token}
      session[:user_id].should ==school_user_request.user_id
    end
    it "shows 404 message for invalid links" do
      get "user_school", {confirmation_token: 'aaa'}
      response.should render_template("errors/404")
    end
  end

  describe "GET 'student'" do
    it "returns http success if in role" do
      session[:user_id] = Fabricate(:user, roles_s: 'student').id
      get 'student'
      response.should be_success
    end
    it "denies access not in role" do
      session[:user_id] = Fabricate(:user).id
      get 'student'
      response.should redirect_to(denied_path)
    end
  end

  describe "GET 'moderator'" do
    it "returns http success if in role" do
      session[:user_id] = Fabricate(:user, roles_s: 'moderator').id
      get 'moderator'
      response.should be_success
    end
    it "denies access not in role" do
      session[:user_id] = Fabricate(:user).id
      get 'moderator'
      response.should redirect_to(denied_path)
    end
  end

  describe "GET 'teacher'" do
    it "returns http success if in role" do
      session[:user_id] = Fabricate(:user, roles_s: 'teacher').id
      get 'teacher'
      response.should be_success
    end
    it "denies access not in role" do
      session[:user_id] = Fabricate(:user).id
      get 'teacher'
      response.should redirect_to(denied_path)
    end
  end

  describe "GET 'admin'" do
    it "returns http success if in role" do
      session[:user_id] = Fabricate(:user, roles_s: 'admin').id
      get 'admin'
      response.should be_success
    end
    it "denies access not in role" do
      session[:user_id] = Fabricate(:user).id
      get 'admin'
      response.should redirect_to(denied_path)
    end
  end

  describe "GET 'master'" do
    it "returns http success if in role" do
      session[:user_id] = Fabricate(:user, roles_s: 'master').id
      get 'master'
      response.should be_success
    end
    it "denies access not in role" do
      session[:user_id] = Fabricate(:user).id
      get 'master'
      response.should redirect_to(denied_path)
    end
  end

end