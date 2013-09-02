class Devise::RegistrationsController < DeviseController
    prepend_before_filter :require_no_authentication, :only => [ :new, :create, :cancel ]
    prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy]
    
    # POST /resource
    def create
        build_resource
        
        if resource.save
            if resource.active_for_authentication?
                set_flash_message :notice, :signed_up if is_navigational_format?
                sign_in(resource_name, resource)
                respond_with resource, :location => after_sign_in_path_for(resource)
                else
                set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
                expire_session_data_after_sign_in!
                respond_with resource, :location => after_inactive_sign_in_path_for(resource)
            end
            if !params[:entity_token].nil?
                sr = SignupRequest.where(email: resource.email).first_or_initialize
                sr.generate_and_mail_new_token
                text = sr.save ? "a confirmation email has been sent to #{resource.email}" : sr.errors.full_messages.to_sentence.to_s
                render text: text
            end

            if !params[:conf_token].nil?
                srr = SignupRequest.find_by_confirmation_token!(params[:conf_token])
                nu_email = srr.email
                entity = Entity.find_by_email_domain(nu_email)
                eur = EntityUser.where(entity_id: entity.id, user_id: current_user.id).first_or_create
                text = "#{current_user.name} #joined the #{entity.name} network.  Take a moment to welcome them."
                @post = Post.where(:text => text, :user_id => current_user.id).create
                @tags = @post.text.scan(/(?:\s|^)(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i)
                if !@tags.nil?
                    @tags.each do |tag|
                        hashtag = Hashtag.where(:name => tag[0]).first_or_create
                        HashtagsPost.create(:post_id => @post.id, :hashtag_id => hashtag.id)
                    end
                end
            end
            else
            clean_up_passwords resource
            respond_with resource
        end
    end
                                                  


                                                  
end

