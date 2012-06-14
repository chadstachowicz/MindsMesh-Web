class HomeController < ApplicationController
  def index
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
    @school_user_request = current_user.school_user_requests.where(school_id: params[:school_id], email: params[:email]).first_or_initialize
    @school_user_request.save
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
