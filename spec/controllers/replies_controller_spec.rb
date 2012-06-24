require 'spec_helper'

describe RepliesController do

  before(:each) do
    @reply = Fabricate(:reply)
    stub!(:current_user).and_return(current_user_master)
  end

  def valid_attributes
    { text: Faker::Lorem.sentence }
  end


  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested reply" do
        Reply.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => @reply.to_param, :reply => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested reply as @reply" do
        put :update, {:id => @reply.to_param, :reply => valid_attributes}, valid_session
        assigns(:reply).should eq(@reply)
      end

      xit "redirects to the reply" do
        put :update, {:id => @reply.to_param, :reply => valid_attributes}, valid_session
        response.should redirect_to(@reply)
      end
    end

    describe "with invalid params" do
      xit "assigns the reply as @reply" do
        # Trigger the behavior that occurs when invalid params are submitted
        Reply.any_instance.stub(:save).and_return(false)
        Reply.any_instance.stub(:errors).and_return(:some => ["errors"])
        put :update, {:id => @reply.to_param, :reply => {}}, valid_session
        assigns(:reply).should eq(@reply)
      end

      xit "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Reply.any_instance.stub(:save).and_return(false)
        Reply.any_instance.stub(:errors).and_return(:some => ["errors"])
        put :update, {:id => @reply.to_param, :reply => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "PUT like" do

    it "creates like" do
      -> {
        put :like, {:id => @reply.to_param}, valid_session
      }.should change(Like, :count).by(1)
    end

    it "creates like assiciated with @reply" do
      -> {
        put :like, {:id => @reply.to_param}, valid_session
      }.should change(@reply.likes, :count).by(1)
    end

    it "creates like assiciated with current_user" do
      -> {
        put :like, {:id => @reply.to_param}, valid_session
      }.should change(current_user.likes, :count).by(1)
    end

    it "can't like @reply twice" do
      -> {
        put :like, {:id => @reply.to_param}, valid_session
        put :like, {:id => @reply.to_param}, valid_session
      }.should change(current_user.likes, :count).by(1)
    end

    it "renders nothing" do
      put :like, {:id => @reply.to_param}, valid_session
      response.body.should == @reply.likes.size.to_s
    end

  end

end