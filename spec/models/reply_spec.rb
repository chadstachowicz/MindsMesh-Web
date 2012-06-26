require 'spec_helper'

describe Reply do
  describe "associations" do
    describe "understands" do
      {user: User, post: Post, likes: Array}.each do |assoc, clazz|
        it assoc do
          reply = Fabricate(:reply)
          reply.should respond_to(assoc)
          reply.send(assoc).should be_a(clazz)
        end
      end
    end
    describe "validating has_many" do
      it "likes" do
        reply = Fabricate.build(:reply) { likes count: 3 }
        reply.likes.size.should ==3
        reply.likes.sample.should be_a Like
      end
    end
  end

  describe "simple field validations" do
    it "requires text" do
      reply = Fabricate.build(:reply, text: nil)
      reply.should_not be_valid
      reply.errors[:text].should_not be_empty
    end
    it "requires text to have at least 10 chars" do
      reply = Fabricate.build(:reply, text: '')
      reply.should_not be_valid
      reply.errors[:text].should_not be_empty
      reply.text = '1'
      reply.valid?
      reply.errors[:text].should be_empty
    end
  end
end
