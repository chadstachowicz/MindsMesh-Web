class TopicsDatatable

     attr_reader :view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Topic.count,
      iTotalDisplayRecords: topics.total_entries,
      aaData: data
    }
  end

  private

  #must match view columns
  def data
    topics.map do |topics|
      [
        name_decorator(topic),
        h(user.created_at),
        entities_decorator(user),
        "#{user.topic_users_count} topics"
      ]
    end
  end

  def name_decorator(user)
    raw [
      image_tag(user.photo_url, width: 20),
      link_to(user.name, user, target: '_blank', data: {user_id: user.id})
    ].join(' ')
  end

  def entities_decorator(user)
    raw [
      "#{user.entity_users_count} entities (",
      link_to(icon_text('caret-right', 'assign'), '#', act: 'open_master_assign_entity_modal', data: {user_id: user.id}),
      ")"
    ].join(' ')
  	
  end

  def users
    @users ||= fetch_users
  end

  def fetch_users
    users = User.order("#{sort_column} #{sort_direction}")
    users = users.page(page).per_page(per_page)
    if params[:sSearch].present?
      users = users.where("upper(name) like upper(:search)", search: "%#{params[:sSearch]}%")
    end
    users
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name created_at entity_users_count topic_users_count]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

end