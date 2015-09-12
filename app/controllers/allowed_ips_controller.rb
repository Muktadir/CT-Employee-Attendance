class AllowedIpsController < ApplicationController
  before_action :set_allowed_ip, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @allowed_ips = AllowedIp.all
    respond_with(@allowed_ips)
  end

  def show
    respond_with(@allowed_ip)
  end

  def new
    @allowed_ip = AllowedIp.new
    respond_with(@allowed_ip)
  end

  def edit
  end

  def create
    @allowed_ip = AllowedIp.new(allowed_ip_params)
    if @allowed_ip.save
      redirect_to root_path
    end
  end

  def update
    @allowed_ip.update(allowed_ip_params)
    respond_with(@allowed_ip)
  end

  def destroy
    @allowed_ip.destroy
    respond_with(@allowed_ip)
  end

  private
    def set_allowed_ip
      @allowed_ip = AllowedIp.find(params[:id])
    end

    def allowed_ip_params
      params.require(:allowed_ip).permit(:name, :ip_address)
    end
end
