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

describe LmsProvidersController do

  # This should return the minimal set of attributes required to create a valid
  # LmsProvider. As you add validations to LmsProvider, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LmsProvidersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all lms_providers as @lms_providers" do
      lms_provider = LmsProvider.create! valid_attributes
      get :index, {}, valid_session
      assigns(:lms_providers).should eq([lms_provider])
    end
  end

  describe "GET show" do
    it "assigns the requested lms_provider as @lms_provider" do
      lms_provider = LmsProvider.create! valid_attributes
      get :show, {:id => lms_provider.to_param}, valid_session
      assigns(:lms_provider).should eq(lms_provider)
    end
  end

  describe "GET new" do
    it "assigns a new lms_provider as @lms_provider" do
      get :new, {}, valid_session
      assigns(:lms_provider).should be_a_new(LmsProvider)
    end
  end

  describe "GET edit" do
    it "assigns the requested lms_provider as @lms_provider" do
      lms_provider = LmsProvider.create! valid_attributes
      get :edit, {:id => lms_provider.to_param}, valid_session
      assigns(:lms_provider).should eq(lms_provider)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new LmsProvider" do
        expect {
          post :create, {:lms_provider => valid_attributes}, valid_session
        }.to change(LmsProvider, :count).by(1)
      end

      it "assigns a newly created lms_provider as @lms_provider" do
        post :create, {:lms_provider => valid_attributes}, valid_session
        assigns(:lms_provider).should be_a(LmsProvider)
        assigns(:lms_provider).should be_persisted
      end

      it "redirects to the created lms_provider" do
        post :create, {:lms_provider => valid_attributes}, valid_session
        response.should redirect_to(LmsProvider.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved lms_provider as @lms_provider" do
        # Trigger the behavior that occurs when invalid params are submitted
        LmsProvider.any_instance.stub(:save).and_return(false)
        post :create, {:lms_provider => { "name" => "invalid value" }}, valid_session
        assigns(:lms_provider).should be_a_new(LmsProvider)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        LmsProvider.any_instance.stub(:save).and_return(false)
        post :create, {:lms_provider => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested lms_provider" do
        lms_provider = LmsProvider.create! valid_attributes
        # Assuming there are no other lms_providers in the database, this
        # specifies that the LmsProvider created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        LmsProvider.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => lms_provider.to_param, :lms_provider => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested lms_provider as @lms_provider" do
        lms_provider = LmsProvider.create! valid_attributes
        put :update, {:id => lms_provider.to_param, :lms_provider => valid_attributes}, valid_session
        assigns(:lms_provider).should eq(lms_provider)
      end

      it "redirects to the lms_provider" do
        lms_provider = LmsProvider.create! valid_attributes
        put :update, {:id => lms_provider.to_param, :lms_provider => valid_attributes}, valid_session
        response.should redirect_to(lms_provider)
      end
    end

    describe "with invalid params" do
      it "assigns the lms_provider as @lms_provider" do
        lms_provider = LmsProvider.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        LmsProvider.any_instance.stub(:save).and_return(false)
        put :update, {:id => lms_provider.to_param, :lms_provider => { "name" => "invalid value" }}, valid_session
        assigns(:lms_provider).should eq(lms_provider)
      end

      it "re-renders the 'edit' template" do
        lms_provider = LmsProvider.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        LmsProvider.any_instance.stub(:save).and_return(false)
        put :update, {:id => lms_provider.to_param, :lms_provider => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested lms_provider" do
      lms_provider = LmsProvider.create! valid_attributes
      expect {
        delete :destroy, {:id => lms_provider.to_param}, valid_session
      }.to change(LmsProvider, :count).by(-1)
    end

    it "redirects to the lms_providers list" do
      lms_provider = LmsProvider.create! valid_attributes
      delete :destroy, {:id => lms_provider.to_param}, valid_session
      response.should redirect_to(lms_providers_url)
    end
  end

end