class ApplicationController < ActionController::Base
  before_filter :block_foreign_ip
  before_filter :authenticate_employee!
  before_filter :set_cache_buster
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def white_listed?(ip)
    return true if ["127.0.5.1", "127.0.0.1"].include?(ip)
    false
  end

  def block_foreign_ip
    redirect_to "http://www.coderstrust.com" unless white_listed?(request.remote_ip)
  end


  def after_sign_in_path_for(resource)

    $absent = Array.new

    @employee = Employee.all()
    date = Time.now.strftime("%d %B %Y").to_s
    @attendances_today = Attendance.where(:date => date )

    @employee.each do |emp|
      @present = false
      @attendances_today.each do |a|
        if emp.email == a.email
          @present = true
        end
      end
      if @present == false
        $absent.push(emp)
      end
    end

    present = true
    if $absent != nil
      $absent.each do |ab|
        if ab.email == current_employee.email
          present = false
          break
        end
      end
    end

    if present == false
      new_attendance_path
    else
      root_path
    end

  end


  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end


end
