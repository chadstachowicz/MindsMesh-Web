class TopicsDatatable
    #delegate :view.params, :h, :link_to, :number_to_currency, :image_tag, :raw, :icon_text, to: :@view
    
    attr_reader :view
    
    def initialize(view)
        @view = view
    end
    
    def as_json(options = {})
        {
            sEcho: view.params[:sEcho].to_i,
            iTotalRecords: User.count,
            iTotalDisplayRecords: topics.total_entries,
            aaData: data
        }
    end
    
    private
    
    # must match view columns
    # <th>Name</th>
    # <th>Slug</th>
    # <th>State</th>
    # <th>Topics</th>
    # <th>Users</th>
    # <th>Actions</th>
    def data
        topics.map do |topic|
            [
            view.link_to(topic.name, topic),
            [view.link_to('Edit', view.edit_topic_path(topic)) + " " + view.link_to('Delete', view.topic_path(topic), :confirm => 'Are you sure you want to destroy this topic?', :method => :delete)]
            ]
        end
    end
    
    def topics
        @topics ||= fetch_topics
    end
    
    def fetch_topics
        current_user = @view.current_user
        if current_user.school_admin?
            entity_ids = current_user.entity_users.where(:role_i => 1).map{|e| e.entity_id}
            ist = Topic.where('entity_id in (:entity_ids)', :entity_ids => entity_ids).order("#{sort_column} #{sort_direction}")
        end
        if current_user.topic_admin?
            topic_ids = current_user.topic_users.where(:role_i => 1).map{|t| t.topic_id}
            list = Topic.where('id in (:topic_ids)', :topic_ids => topic_ids).order("#{sort_column} #{sort_direction}")
        else
            list = Topic.order("#{sort_column} #{sort_direction}")
        end
        list = list.page(page).per_page(per_page)
        if view.params[:sSearch].present?
            list = list.where("upper(name) like :search", search: "%#{view.params[:sSearch].upcase}%")
        end
        list
    end
    
    def page
        view.params[:iDisplayStart].to_i/per_page + 1
    end
    
    def per_page
        view.params[:iDisplayLength].to_i > 0 ? view.params[:iDisplayLength].to_i : 10
    end
    
    def sort_column
        columns = %w[name slug state topics_count topic_users_count id]
        columns[view.params[:iSortCol_0].to_i]
    end
    
    def sort_direction
        view.params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end
    
end