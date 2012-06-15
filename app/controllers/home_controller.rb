class HomeController < ApplicationController
  def index
#    
    redirect_to_landing_home_page
  end

  def guest
    authorize! :home_guest, nil
  end

  def user
    authorize! :home_user, nil
    @school = School.first
    @school_user_request = @school.school_user_requests.build
  end

  def user_create_school_request
    authorize! :home_user, nil
    @school_user_request = current_user.school_user_requests.where(params[:school_user_request]).first_or_initialize
    @school_user_request.save
  end

  def user_school
    sur = SchoolUserRequest.find_by_confirmation_token!(params[:confirmation_token])
    session[:user_id] = sur.confirm
    redirect_to_landing_home_page
  end

  def student
    authorize! :home_student, nil
  end

  def moderator
    authorize! :home_moderator, nil
  end

  def teacher
    authorize! :home_teacher, nil
  end

  def admin
    authorize! :home_admin, nil
  end

  def master
    authorize! :home_master, nil
  end
end
