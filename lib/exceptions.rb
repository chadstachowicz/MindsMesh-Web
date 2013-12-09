
module Exceptions
  class MemberOverFlow < StandardError
  end
  rescue_from MemberOverFlow do |exception|
    redirect_to root_url, :alert => exception.message
  end
end

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

# raise Error::NotPermittedToJoin unless self.permitted?(user)

#rescue Group::Error::Standard => exception
#    flash[:error] = exception.message
#    render :action => 'request'
#end
