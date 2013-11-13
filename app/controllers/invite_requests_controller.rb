class InviteRequestsController < ApplicationController
  load_and_authorize_resource
=begin
  # TODO: name these comments properly with all the matching URLs to each action
  # GET /invite_requests
  def index
  end

  # GET /invite_requests/new
  def new
  end
=end

  # GET /invite_requests/1
  def show
  end

  # POST /invite_requests.json
  def create
    p = params[:invite_request]
      if !params[:invite_receiver_ids].empty?
          users = params[:invite_receiver_ids].split(/,/)
          users.each do |u|
              conditions = {user_id:    me.id,
                  entity_id:  p[:entity_id],
                  group_id:   p[:group_id],
                  to_user_id:  u
              }
              @invite_request = InviteRequest.where(conditions).first_or_create
            end
              
          Resque.enqueue(NotifyNewInvite, p[:group_id], me.id, params[:invite_receiver_ids])
      end
      if !params[:emails].empty?
          emails = params[:emails].split(/[\s,;]/).select { |s| !s.blank? && s =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }.uniq
          not_ids = []
          emails.each do |eml|
              u = User.find_by_email(eml)
              if !u.nil?
                  not_ids.push(u.id)
              end
          end
          if !not_ids.empty?
              not_ids.to_sentence
              Resque.enqueue(NotifyNewInvite, p[:group_id], me.id, params[:invite_receiver_ids])
          end
          conditions = {user_id:    me.id,
              entity_id:  p[:entity_id],
              group_id:   p[:group_id],
          }
          @invite_request = InviteRequest.where(conditions).first_or_create
          @invite_request.send_emails(emails)
      end
      flash[:notice] = "Invites sent successfully!"
      redirect_to :back
  end

=begin
  # GET /invite_requests/1/edit
  def edit
  end

  # PUT /invite_requests/1
  def update
    if @invite_request.update_attributes(params[:invite_request])
      redirect_to @invite_request, notice: 'Invite request was updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /invite_requests/1
  def destroy
    @invite_request.destroy
    redirect_to invite_requests_url
  end
=end

end

=begin
  # GET /invite_requests
  # GET /invite_requests.json
  def index
    @invite_requests = InviteRequest.all

    #beyond simple html
    respond_to do |format|
      format.html {  } # index.html.erb
      format.js   {  } # index.js.erb
      format.json { render json: @invite_requests }
    end
  end

  # GET /invite_requests/1
  # GET /invite_requests/1.json
  def show
    @invite_request = InviteRequest.find(params[:id])

    #beyond simple html
    respond_to do |format|
      format.html {  } # show.html.erb
      format.js   {  } # show.js.erb
      format.json { render json: @invite_request }
    end
  end

  # GET /invite_requests/new
  # GET /invite_requests/new.json
  def new
    @invite_request = InviteRequest.new
    #beyond simple html, use show code
  end

  # GET /invite_requests/1/edit
  def edit
    @invite_request = InviteRequest.find(params[:id])
    #beyond simple html, use show code
  end

  # POST /invite_requests
  # POST /invite_requests.json
  def create
    @invite_request = InviteRequest.new(params[:invite_request])

    #beyond simple html
    respond_to do |format|
      if @invite_request.save
        format.html { redirect_to @invite_request, notice: 'Invite request was created.' }
        format.js   {  } # create.js.erb
        format.json { render json: @invite_request, status: :created, location: @invite_request }
      else
        format.html { render action: "new" }
        format.js   {  } # create.js.erb
        #format.js   { render 'create_fail' } # create_fail.js.erb
        format.json { render json: @invite_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invite_requests/1
  # PUT /invite_requests/1.json
  def update
    @invite_request = InviteRequest.find(params[:id])

    #beyond simple html
    respond_to do |format|
      if @invite_request.update_attributes(params[:invite_request])
        format.html { redirect_to @invite_request, notice: 'Invite request was updated.' }
        format.js   {  } # update.js.erb
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js   {  } # update.js.erb
        #format.js   { render 'update_fail' } # update_fail.js.erb
        format.json { render json: @invite_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invite_requests/1
  # DELETE /invite_requests/1.json
  def destroy
    @invite_request = InviteRequest.find(params[:id])
    @invite_request.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to invite_requests_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
=end