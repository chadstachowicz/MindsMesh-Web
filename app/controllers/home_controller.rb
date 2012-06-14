class HomeController < ApplicationController
  def index
    return redirect_to :home_guest     unless current_user
    return redirect_to :home_user      if current_user.user?
    return redirect_to :home_student   if current_user.student?
    return redirect_to :home_moderator if current_user.moderator?
    return redirect_to :home_teacher   if current_user.teacher?
    return redirect_to :home_admin     if current_user.admin?
    return redirect_to :home_master    if current_user.master?
  end

  def guest
    authorize! :home_guest, nil
  end

  def user
    authorize! :home_user, nil
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
