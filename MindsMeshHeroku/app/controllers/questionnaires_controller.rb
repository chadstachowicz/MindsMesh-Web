class QuestionnairesController < ApplicationController
  respond_to :html#, :json, :xml
  load_and_authorize_resource

  # GET /questionnaires
  def index
    respond_with(@questionnaires)
  end

  # GET /questionnaires/1
  def show
    @previous      = Questionnaire.where("id < ?", params[:id]).first || Questionnaire.first
    @next          = Questionnaire.where("id > ?", params[:id]).first || Questionnaire.first
    respond_with(@questionnaire)
  end

  # DELETE /questionnaires/1
  def destroy
    @questionnaire.destroy
    redirect_to questionnaires_path
  end
end
=begin

  # GET /questionnaires/new
  def new
    @questionnaire = Questionnaire.new
    respond_with(@questionnaire)
  end

  # GET /questionnaires/1/edit
  def edit
    @questionnaire = Questionnaire.find(params[:id])
    respond_with(@questionnaire)
  end

  # POST /questionnaires
  def create
    @questionnaire = Questionnaire.new
    if @questionnaire.save
      flash[:notice] = "Questionnaire successfully created."
    end
    respond_with(@questionnaire, location: @questionnaire)
  end

  # PUT /questionnaires/1
  def update
    @questionnaire = Questionnaire.find(params[:id])
    if @questionnaire.update_attributes(params[:questionnaire])
      flash[:notice] = "Questionnaire successfully updated."
    end
    respond_with(@questionnaire, location: @questionnaire)
  end

=end