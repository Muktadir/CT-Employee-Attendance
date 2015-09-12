class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]

  respond_to :html
  def index
    @attendance = Attendance.new
    $absent = Array.new
    @employee = Employee.all()

    date = Time.now.strftime("%d %B %Y").to_s
    @attendances = Attendance.all
    @attendances_today = @attendances.where(:date => date)
    @present_today = @attendances.where(:date => date).where(:leave => false)
    @on_leave = @attendances.where(:date => date).where(:leave => true)

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
    # respond_with(@attendances)
  end

  def show
    respond_with(@attendance)
  end

  def new
    @attendance = Attendance.new
    respond_with(@attendance)
  end

  def edit
  end

  def create
    @attendance = Attendance.new(attendance_params)

    if @attendance.save
     redirect_to root_path
    else
      redirect_to new_attendance_path
    end
  end

  def update
    if @attendance.email == current_employee.email
      if @attendance.update_attribute(:logout_at, Time.now+6.hours)
        # sign_out
        redirect_to root_path
      end
    elsif @attendance.email != current_employee.email
      if @attendance.update(attendance_params)
        redirect_to root_path
      end
    end
  end

  def destroy
    @attendance.destroy
    respond_with(@attendance)
  end

  def by_name
    email = params[:email]
    if email.present?
      start_date = DateTime.parse(params["start_date"].values.join("-"))
      end_date = DateTime.parse(params["end_date"].values.join("-"))
    end
    @attendances = Attendance.all
    @report_by_name = @attendances.where(created_at:  start_date..end_date).where(:email => email)
    @leave_count = @report_by_name.where(:leave => true).count
    # @present_today = @attendances.where(:date => date).where(:leave => false)
  end

  def by_date
    date = params[:start_date]
    if date.present?
      start_date = DateTime.parse(params["start_date"].values.join("-"))
      end_date = DateTime.parse(params["end_date"].values.join("-"))
    end
    @report_by_date = Attendance.where(created_at:  start_date..end_date)
  end

  def make_leave
    @employee = Employee.find(params[:e_id])
    @attendance = Attendance.new
    respond_with(@attendance)
  end

  def create_leave
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      redirect_to root_path
    else
      redirect_to new_attendance_path
    end

  end

  private
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    def attendance_params
      params.require(:attendance).permit(:firstname, :lastname, :email, :date.to_s, :login_at, :logout_at, :present, :leave, :leave_cause)
    end

end
