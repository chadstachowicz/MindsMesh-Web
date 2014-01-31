require 'spec_helper'

describe QuestionnairesController do

  before do
    @questionnaire = Fabricate(:questionnaire)
  end

  describe "GET index" do
    it "assigns all questionnaires as @questionnaires" do
      get :index, {}, valid_session
      assigns(:questionnaires).should eq([@questionnaire])
    end
  end

  describe "GET show" do
    it "assigns the requested questionnaire as @questionnaire" do
      get :show, {:id => @questionnaire.to_param}, valid_session
      assigns(:questionnaire).should eq(@questionnaire)
    end
  end
  describe "DELETE destroy" do
    it "destroys the requested questionnaire" do
      expect {
        delete :destroy, {:id => @questionnaire.to_param}, valid_session
      }.to change(Questionnaire, :count).by(-1)
    end

    it "redirects to the questionnaires list" do
      delete :destroy, {:id => @questionnaire.to_param}, valid_session
      response.should redirect_to(questionnaires_url)
    end
  end

end
=begin
  describe "GET new" do
    it "assigns a new questionnaire as @questionnaire" do
      get :new, {}, valid_session
      assigns(:questionnaire).should be_a_new(Questionnaire)
    end
  end

  describe "GET edit" do
    it "assigns the requested questionnaire as @questionnaire" do
      questionnaire = Questionnaire.create! valid_attributes
      get :edit, {:id => questionnaire.to_param}, valid_session
      assigns(:questionnaire).should eq(questionnaire)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Questionnaire" do
        expect {
          post :create, {:questionnaire => valid_attributes}, valid_session
        }.to change(Questionnaire, :count).by(1)
      end

      it "assigns a newly created questionnaire as @questionnaire" do
        post :create, {:questionnaire => valid_attributes}, valid_session
        assigns(:questionnaire).should be_a(Questionnaire)
        assigns(:questionnaire).should be_persisted
      end

      it "redirects to the created questionnaire" do
        post :create, {:questionnaire => valid_attributes}, valid_session
        response.should redirect_to(Questionnaire.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved questionnaire as @questionnaire" do
        # Trigger the behavior that occurs when invalid params are submitted
        Questionnaire.any_instance.stub(:save).and_return(false)
        Questionnaire.any_instance.stub(:errors).and_return(:some => ["errors"])
        post :create, {:questionnaire => {}}, valid_session
        assigns(:questionnaire).should be_a_new(Questionnaire)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Questionnaire.any_instance.stub(:save).and_return(false)
        Questionnaire.any_instance.stub(:errors).and_return(:some => ["errors"])
        post :create, {:questionnaire => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested questionnaire" do
        questionnaire = Questionnaire.create! valid_attributes
        # Assuming there are no other questionnaires in the database, this
        # specifies that the Questionnaire created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Questionnaire.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => questionnaire.to_param, :questionnaire => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested questionnaire as @questionnaire" do
        questionnaire = Questionnaire.create! valid_attributes
        put :update, {:id => questionnaire.to_param, :questionnaire => valid_attributes}, valid_session
        assigns(:questionnaire).should eq(questionnaire)
      end

      it "redirects to the questionnaire" do
        questionnaire = Questionnaire.create! valid_attributes
        put :update, {:id => questionnaire.to_param, :questionnaire => valid_attributes}, valid_session
        response.should redirect_to(questionnaire)
      end
    end

    describe "with invalid params" do
      it "assigns the questionnaire as @questionnaire" do
        questionnaire = Questionnaire.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Questionnaire.any_instance.stub(:save).and_return(false)
        Questionnaire.any_instance.stub(:errors).and_return(:some => ["errors"])
        put :update, {:id => questionnaire.to_param, :questionnaire => {}}, valid_session
        assigns(:questionnaire).should eq(questionnaire)
      end

      it "re-renders the 'edit' template" do
        questionnaire = Questionnaire.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Questionnaire.any_instance.stub(:save).and_return(false)
        Questionnaire.any_instance.stub(:errors).and_return(:some => ["errors"])
        put :update, {:id => questionnaire.to_param, :questionnaire => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end
=end