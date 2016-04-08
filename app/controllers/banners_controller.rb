class BannersController < ApplicationController
  unloadable

  before_action :auth_logged
  before_action :auth_user, except: [:show_all, :close]

  def index
    @bannerss = BannerNotification.all.order(:time_to)
  end

  def show_all
    @bannerss = BannerNotification.good_time.select do |bann|
      if bann.groups == [''] || ((User.current.groups.map { |gr| gr.lastname }) & (bann.groups - [nil, ''])).size > 0 || bann.groups == []
        bann if bann.project_id.nil? || bann.project.users.include?(User.current)
      end
    end
  end

  def new
    @banner = BannerNotification.new
  end

  def create
    @banner = BannerNotification.new(banner_params)
    if @banner.save
      redirect_to banners_path, notice: 'You successfully created banner notification!'
    else
      render 'new'
    end
  end

  def edit
    @banner = BannerNotification.find(params[:id])
  end

  def update
    @banner = BannerNotification.find(params[:id])
    if @banner.update(banner_params)
      redirect_to banners_path, notice: 'You successfully updated banner notification!'
    else
      render 'edit'
    end
  end

  def destroy
    @banner = BannerNotification.find(params[:id])
    if @banner.destroy
      redirect_to banners_path, notice: 'Banner was successfully deleted!'
    else
      redirect_to banners_path, alert: 'There was a problem with deleting this banner. Please try again later.'
    end
  end

  def close
    if BannerNotification.find(params[:banner_id].to_i).hideable
      ClosedBanner.create(user_id: params[:user_id_banner].to_i, banner_notification_id: params[:banner_id].to_i)
    end
    render nothing: true
  end

  private

  def banner_params
    params.require(:banner_notification).permit(:content, :time_from, :time_to, :hideable, :notification_type, :project_id, :active, groups: [])
  end

  def auth_user
    deny_access unless User.current.admin? || Setting.plugin_redmine_banner_notifications['banner_admins'].map(&:to_i).include?(User.current.try(:id))
  end

  def auth_logged
    deny_access unless User.current.logged?
  end

end
