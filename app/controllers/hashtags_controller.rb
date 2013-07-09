class HashtagsController < ApplicationController
  load_and_authorize_resource
  
  # TODO: name these comments properly with all the matching URLs to each action
  # GET /hashtags
  def index
  end

  # GET /hashtags/1
  def show
      @hashtag = Hashtag.find_by_name(params[:tag])
      @posts = @hashtag.posts.as_feed(params.slice(:limit, :before))
  end

  # GET /hashtags/new
  def new
  end

  # POST /hashtags
  def create
    if @hashtag.save
      redirect_to @hashtag, notice: 'Hashtag was created.'
    else
      render action: "new"
    end
  end

  # GET /hashtags/1/edit
  def edit
  end

  # PUT /hashtags/1
  def update
    if @hashtag.update_attributes(params[:hashtag])
      redirect_to @hashtag, notice: 'Hashtag was updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /hashtags/1
  def destroy
    @hashtag.destroy
    redirect_to hashtags_url
  end

end

=begin
  # GET /hashtags
  # GET /hashtags.json
  def index
    @hashtags = Hashtag.all

    #beyond simple html
    respond_to do |format|
      format.html {  } # index.html.erb
      format.js   {  } # index.js.erb
      format.json { render json: @hashtags }
    end
  end

  # GET /hashtags/1
  # GET /hashtags/1.json
  def show
    @hashtag = Hashtag.find(params[:id])

    #beyond simple html
    respond_to do |format|
      format.html {  } # show.html.erb
      format.js   {  } # show.js.erb
      format.json { render json: @hashtag }
    end
  end

  # GET /hashtags/new
  # GET /hashtags/new.json
  def new
    @hashtag = Hashtag.new
    #beyond simple html, use show code
  end

  # GET /hashtags/1/edit
  def edit
    @hashtag = Hashtag.find(params[:id])
    #beyond simple html, use show code
  end

  # POST /hashtags
  # POST /hashtags.json
  def create
    @hashtag = Hashtag.new(params[:hashtag])

    #beyond simple html
    respond_to do |format|
      if @hashtag.save
        format.html { redirect_to @hashtag, notice: 'Hashtag was created.' }
        format.js   {  } # create.js.erb
        format.json { render json: @hashtag, status: :created, location: @hashtag }
      else
        format.html { render action: "new" }
        format.js   {  } # create.js.erb
        #format.js   { render 'create_fail' } # create_fail.js.erb
        format.json { render json: @hashtag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hashtags/1
  # PUT /hashtags/1.json
  def update
    @hashtag = Hashtag.find(params[:id])

    #beyond simple html
    respond_to do |format|
      if @hashtag.update_attributes(params[:hashtag])
        format.html { redirect_to @hashtag, notice: 'Hashtag was updated.' }
        format.js   {  } # update.js.erb
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js   {  } # update.js.erb
        #format.js   { render 'update_fail' } # update_fail.js.erb
        format.json { render json: @hashtag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hashtags/1
  # DELETE /hashtags/1.json
  def destroy
    @hashtag = Hashtag.find(params[:id])
    @hashtag.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to hashtags_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
=end