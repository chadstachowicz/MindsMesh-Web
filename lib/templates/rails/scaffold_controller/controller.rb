<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  respond_to :html#, :json, :xml

  # GET <%= route_url %>
  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
    respond_with(@<%= plural_table_name %>)
  end

  # GET <%= route_url %>/1
  def show
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    respond_with(@<%= singular_table_name %>)
  end

  # GET <%= route_url %>/new
  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    respond_with(@<%= singular_table_name %>)
  end

  # GET <%= route_url %>/1/edit
  def edit
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    respond_with(@<%= singular_table_name %>)
  end

  # POST <%= route_url %>
  def create
    @<%= singular_table_name %> = <%= class_name %>.create(params[:<%= singular_table_name %>])

    if @<%= singular_table_name %>.persisted?
      flash[:notice] = "<%= human_name %> successfully created."
    end
    respond_with(@<%= singular_table_name %>, location: @<%= singular_table_name %>)
  end

  # PUT <%= route_url %>/1
  def update
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    
    #@<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %>
    if @<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %>
      flash[:notice] = "<%= human_name %> successfully updated."
    end
    respond_with(@<%= singular_table_name %>, location: @<%= singular_table_name %>)
  end

  # DELETE <%= route_url %>/1
  def destroy
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    @<%= orm_instance.destroy %>
    respond_with(@<%= singular_table_name %>)
  end
end
<% end -%>
