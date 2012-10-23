require 'spec_helper'

describe Questionnaire do


  describe "associations" do
    describe "understands belongs_to" do
      {user: User}.each do |assoc, clazz|
        it assoc do
          record = Fabricate(:questionnaire)
          record.should respond_to(assoc)
          record.send(assoc).should be_a(clazz)
        end
      end
    end
    describe "validations" do
      it "presence of user" do
        q = Fabricate.build(:questionnaire, user: nil)
        q.should_not be_valid
        q.errors[:user].should be_any
      end
    end
  end

  describe "AVAILABLE_QUESTIONS" do
    Questionnaire::AVAILABLE_QUESTIONS.each do |attr_name|
      it "#{attr_name} should be a valid attribute name" do
        Questionnaire::AVAILABLE_QUESTIONS.should include(attr_name)
      end
    end
  end

  describe "sample_blank_question" do
    before do
      @q = Fabricate(:questionnaire)
    end
    it "brings a random valid attribute name" do
      (Questionnaire::AVAILABLE_QUESTIONS.size).times do
        r = @q.sample_blank_question
        Questionnaire::AVAILABLE_QUESTIONS.should include(r)
      end
    end
    it "returns nil when all questions are answered" do
      (Questionnaire::AVAILABLE_QUESTIONS.size).times do
        r = @q.sample_blank_question
        Questionnaire::AVAILABLE_QUESTIONS.should include(r)
        @q.send("#{r}=", "lalala")
      end
      r = @q.sample_blank_question
      r.should be_nil
    end
    it "does not return answered questions" do
      @q.q1 = "lalala"
      @q.q2 = "lalala"
      (Questionnaire::AVAILABLE_QUESTIONS.size-2).times do
        r = @q.sample_blank_question
        r.should_not == :q1
        r.should_not == :q2
        @q.send("#{r}=", "lalala")
      end
    end
  end

end
