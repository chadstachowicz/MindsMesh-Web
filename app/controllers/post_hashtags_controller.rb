class PostHashtagsController < ApplicationController
  load_and_authorize_resource
  
  # TODO: name these comments properly with all the matching URLs to each action
  # GET /post_hashtags
  def index
  end

  # GET /post_hashtags/1
  def show
  end

  # GET /post_hashtags/new
  def new
  end

  # POST /post_hashtags
  def create
    if @post_hashtag.save
      redirect_to @post_hashtag, notice: 'Post hashtag was created.'
    else
      render action: "new"
    end
  end

  # GET /post_hashtags/1/edit
  def edit
  end

  # PUT /post_hashtags/1
  def update
    if @post_hashtag.update_attributes(params[:post_hashtag])
      redirect_to @post_hashtag, notice: 'Post hashtag was updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /post_hashtags/1
  def destroy
    @post_hashtag.destroy
    redirect_to post_hashtags_url
  end

end

=begin
  # GET /post_hashtags
  # GET /post_hashtags.json
  def index
    @post_hashtags = PostHashtag.all

    #beyond simple html
    respond_to do |format|
      format.html {  } # index.html.erb
      format.js   {  } # index.js.erb
      format.json { render json: @post_hashtags }
    end
  end

  # GET /post_hashtags/1
  # GET /post_hashtags/1.json
  def show
    @post_hashtag = PostHashtag.find(params[:id])

    #beyond simple html
    respond_to do |format|
      format.html {  } # show.html.erb
      format.js   {  } # show.js.erb
      format.json { render json: @post_hashtag }
    end
  end

  # GET /post_hashtags/new
  # GET /post_hashtags/new.json
  def new
    @post_hashtag = PostHashtag.new
    #beyond simple html, use show code
  end

  # GET /post_hashtags/1/edit
  def edit
    @post_hashtag = PostHashtag.find(params[:id])
    #beyond simple html, use show code
  end

  # POST /post_hashtags
  # POST /post_hashtags.json
  def create
    @post_hashtag = PostHashtag.new(params[:post_hashtag])

    #beyond simple html
    respond_to do |format|
      if @post_hashtag.save
        format.html { redirect_to @post_hashtag, notice: 'Post hashtag was created.' }
        format.js   {  } # create.js.erb
        format.json { render json: @post_hashtag, status: :created, location: @post_hashtag }
      else
        format.html { render action: "new" }
        format.js   {  } # create.js.erb
        #format.js   { render 'create_fail' } # create_fail.js.erb
        format.json { render json: @post_hashtag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /post_hashtags/1
  # PUT /post_hashtags/1.json
  def update
    @post_hashtag = PostHashtag.find(params[:id])

    #beyond simple html
    respond_to do |format|
      if @post_hashtag.update_attributes(params[:post_hashtag])
        format.html { redirect_to @post_hashtag, notice: 'Post hashtag was updated.' }
        format.js   {  } # update.js.erb
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js   {  } # update.js.erb
        #format.js   { render 'update_fail' } # update_fail.js.erb
        format.json { render json: @post_hashtag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_hashtags/1
  # DELETE /post_hashtags/1.json
  def destroy
    @post_hashtag = PostHashtag.find(params[:id])
    @post_hashtag.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to post_hashtags_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
=end