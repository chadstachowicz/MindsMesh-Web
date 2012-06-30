class Questionnaire < ActiveRecord::Base
  belongs_to :user
  attr_accessible :q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9
  validates_presence_of :user

  AVAILABLE_QUESTIONS = [:q1, :q2, :q3, :q4, :q6]

  QUESTIONS = {
    q1: 'How would you <span class="label label-warning">rate</span> BrainsMesh?',
    q2: 'What you <span class="label label-warning">like</span> the most about BrainsMesh?',
    q3: 'What do you <span class="label label-warning">not like</span> about BrainsMesh?',
    q4: 'How do you usually do <span class="label label-warning">group studying</span> ?',
    q5: 'Do you have an <span class="label label-warning">ipad</span> ? Other tablet? Use it <span class="label label-warning">frequently</span> ? What are your favorite apps?',
    q6: 'What would you <span class="label label-warning">ask us</span> to add?'
  }

  def sample_blank_question
    questions = AVAILABLE_QUESTIONS.shuffle
    while attr_name = questions.pop
      return attr_name if self.send(attr_name).blank?
    end
    nil
  end
end
