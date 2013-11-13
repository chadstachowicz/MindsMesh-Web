require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe Admin::NewslettersController do

  # This should return the minimal set of attributes required to create a valid
  # Admin::Newsletter. As you add validations to Admin::Newsletter, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "title" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Admin::NewslettersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all admin_newsletters as @admin_newsletters" do
      newsletter = Admin::Newsletter.create! valid_attributes
      get :index, {}, valid_session
      assigns(:admin_newsletters).should eq([newsletter])
    end
  end

  describe "GET show" do
    it "assigns the requested admin_newsletter as @admin_newsletter" do
      newsletter = Admin::Newsletter.create! valid_attributes
      get :show, {:id => newsletter.to_param}, valid_session
      assigns(:admin_newsletter).should eq(newsletter)
    end
  end

  describe "GET new" do
    it "assigns a new admin_newsletter as @admin_newsletter" do
      get :new, {}, valid_session
      assigns(:admin_newsletter).should be_a_new(Admin::Newsletter)
    end
  end

  describe "GET edit" do
    it "assigns the requested admin_newsletter as @admin_newsletter" do
      newsletter = Admin::Newsletter.create! valid_attributes
      get :edit, {:id => newsletter.to_param}, valid_session
      assigns(:admin_newsletter).should eq(newsletter)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Admin::Newsletter" do
        expect {
          post :create, {:admin_newsletter => valid_attributes}, valid_session
        }.to change(Admin::Newsletter, :count).by(1)
      end

      it "assigns a newly created admin_newsletter as @admin_newsletter" do
        post :create, {:admin_newsletter => valid_attributes}, valid_session
        assigns(:admin_newsletter).should be_a(Admin::Newsletter)
        assigns(:admin_newsletter).should be_persisted
      end

      it "redirects to the created admin_newsletter" do
        post :create, {:admin_newsletter => valid_attributes}, valid_session
        response.should redirect_to(Admin::Newsletter.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved admin_newsletter as @admin_newsletter" do
        # Trigger the behavior that occurs when invalid params are submitted
        Admin::Newsletter.any_instance.stub(:save).and_return(false)
        post :create, {:admin_newsletter => { "title" => "invalid value" }}, valid_session
        assigns(:admin_newsletter).should be_a_new(Admin::Newsletter)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Admin::Newsletter.any_instance.stub(:save).and_return(false)
        post :create, {:admin_newsletter => { "title" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested admin_newsletter" do
        newsletter = Admin::Newsletter.create! valid_attributes
        # Assuming there are no other admin_newsletters in the database, this
        # specifies that the Admin::Newsletter created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Admin::Newsletter.any_instance.should_receive(:update_attributes).with({ "title" => "MyString" })
        put :update, {:id => newsletter.to_param, :admin_newsletter => { "title" => "MyString" }}, valid_session
      end

      it "assigns the requested admin_newsletter as @admin_newsletter" do
        newsletter = Admin::Newsletter.create! valid_attributes
        put :update, {:id => newsletter.to_param, :admin_newsletter => valid_attributes}, valid_session
        assigns(:admin_newsletter).should eq(newsletter)
      end

      it "redirects to the admin_newsletter" do
        newsletter = Admin::Newsletter.create! valid_attributes
        put :update, {:id => newsletter.to_param, :admin_newsletter => valid_attributes}, valid_session
        response.should redirect_to(newsletter)
      end
    end

    describe "with invalid params" do
      it "assigns the admin_newsletter as @admin_newsletter" do
        newsletter = Admin::Newsletter.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Admin::Newsletter.any_instance.stub(:save).and_return(false)
        put :update, {:id => newsletter.to_param, :admin_newsletter => { "title" => "invalid value" }}, valid_session
        assigns(:admin_newsletter).should eq(newsletter)
      end

      it "re-renders the 'edit' template" do
        newsletter = Admin::Newsletter.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Admin::Newsletter.any_instance.stub(:save).and_return(false)
        put :update, {:id => newsletter.to_param, :admin_newsletter => { "title" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested admin_newsletter" do
      newsletter = Admin::Newsletter.create! valid_attributes
      expect {
        delete :destroy, {:id => newsletter.to_param}, valid_session
      }.to change(Admin::Newsletter, :count).by(-1)
    end

    it "redirects to the admin_newsletters list" do
      newsletter = Admin::Newsletter.create! valid_attributes
      delete :destroy, {:id => newsletter.to_param}, valid_session
      response.should redirect_to(admin_newsletters_url)
    end
  end

end
