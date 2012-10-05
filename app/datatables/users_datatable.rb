class UsersDatatable
  delegate :params, :h, :link_to, :number_to_currency, :image_tag, :raw, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: User.count,
      iTotalDisplayRecords: users.total_entries,
      aaData: data
    }
  end

  private

  #must match view columns
  def data
    users.map do |user|
      [
        name_decorator(user),
        h(user.created_at),
        "#{user.entity_users_count} entities",
        "#{user.topic_users_count} topics"
      ]
    end
  end

  def name_decorator(user)
    raw [
      image_tag(user.photo_url, width: 20),
      link_to(user.name, user, target: '_blank')
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