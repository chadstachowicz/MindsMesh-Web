

# raise Exception::MemberOverFlow"member count overflow"

class Group
  module Error
    class Standard < StandardError; end

    class AlreadyAMember < Standard
      def message
        "You are already a member of this group."
      end
    end

    class NotPermittedToJoin < Standard
      def message
        "You don't have the proper permissions to join this group."
      end
    end
  end
end

class Mailer
  module Error
    class Standard < StandardError; end

    class NotUSer < Standard
      def message
        "Apparently there is no user to send this email"
      end
    end

    class SendGridFail < Standard
      def message
        "Something went wrong with sendgrid"
      end
    end
  end
end

# raise Error::SendGridFail unless self.permitted?(user)

#rescue Group::Error::Standard => exception
#    flash[:error] = exception.message
#    render :action => 'request'
#end

#rescue Group::Error::Standard => exception
#    flash[:error] = exception.message
#    render :action => 'request'
#end


module CampaignErrorDisplay

  @@errors = {
    Admin::Campaign::Error::NotUser => "You are already a member of this group.",
    Admin::Campaign::Error::SendGridFail => "You don't have the proper permissions to join this group."
  }
 
  def self.message(error)
    @@errors[error.class]
  end
end