# initializers/omniauth.rb

module OmniAuth::Strategies
    
    class EduFacebook < Facebook
        def name
            :edu_facebook
        end
    end
    
    class UcFacebook < Facebook
        def name
            :uc_facebook
        end 
    end
    
end