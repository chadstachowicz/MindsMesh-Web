
# MindsMesh, Inc. (c) 2012-2013

class Admin::Campaign < ActiveRecord::Base

  belongs_to :newsletter

  attr_accessible :kind, :element_id, :historic, :newsletter_id, :entity_id

  def send_mails_and_save(data)
        data.each do |d|
            #user = User.where( entity_id:d.entity_id)
            transaction do
                #admin_campaign = new(params[:admin_campaign])

                if save
                    # logger.debug "eur saved!!"
                    MyMail.confirmation(self).deliver
                end
            end    
        end
  end

  private
  def mass_assignment_authorizer
    # super + [:college_id]
    super + (accessible || [])
  end

end
