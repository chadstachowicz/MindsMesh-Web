class V1::UserPresenter < V1::BasePresenter

  def as_json(options={})
    #m.as_json(options)
    {
    	id:     m.id,
    	gender: m.gender,
    	name:   m.name,
    	role:   m.role,
    	posts_count: m.posts_count,
    	photo_url: m.photo_url
    }
  end
  
end
