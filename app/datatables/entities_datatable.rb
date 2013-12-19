class EntitiesDatatable
  #delegate :view.params, :h, :link_to, :number_to_currency, :image_tag, :raw, :icon_text, to: :@view

  attr_reader :view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: view.params[:sEcho].to_i,
      iTotalRecords: User.count,
      iTotalDisplayRecords: entities.total_entries,
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
    entities.map do |entity|
      [
        view.link_to(entity.name, entity),
        entity.slug,
        entity.state_name,
        "#{entity.topics_count} topics",
        "#{entity.entity_users_count} users",   
        [view.link_to('Edit', view.edit_entity_path(entity)) + "          " + view.link_to('Advanced Settings', view.entity_settings_path(entity))]
      ]
    end
  end

  def entities
    @entities ||= fetch_entities
  end

  def fetch_entities
    list = Entity.order("#{sort_column} #{sort_direction}")
    list = list.page(page).per_page(per_page)
    if view.params[:sSearch].present?
      list = list.where("upper(name) like :search OR upper(state_name) like :search OR upper(slug) like :search", search: "%#{view.params[:sSearch].upcase}%")
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