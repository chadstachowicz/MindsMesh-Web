class Questionnaire < ActiveRecord::Base
  belongs_to :user
  attr_accessible :q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :q10,
                  :q11, :q12, :q13, :q14, :q15, :q16, :q17, :q18, :q19, :q20
  validates_presence_of :user

  AVAILABLE_QUESTIONS = [:q1, :q2, :q3, :q4, :q6, :q7]

  QUESTIONS = {
    q1: 'How would you <span class="label label-warning">rate</span> Minds Mesh?',
    q2: 'What you <span class="label label-warning">like</span> the most about Minds Mesh?',
    q3: 'What do you <span class="label label-warning">not like</span> about Minds Mesh?',
    q4: 'How do you usually do <span class="label label-warning">group studying</span> ?',
    q5: 'Would you like to see MindsMesh on <span class="label label-warning">mobile</span> and <span class="label label-warning">tablet</span> devices? Which platform?',
    q6: 'What would you like us to <span class="label label-warning">add</span> ?',
    q7: 'Is there any other <span class="label label-warning">class</span> you would like to use Minds Mesh for?'
  }

  def sample_blank_question
    questions = AVAILABLE_QUESTIONS.shuffle
    while attr_name = questions.pop
      return attr_name if self.send(attr_name).blank?
    end
    nil
  end
end
