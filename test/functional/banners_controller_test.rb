require File.expand_path('../../test_helper', __FILE__)

class BannersControllerTest < Redmine::IntegrationTest
  self.fixture_path = File.join(File.dirname(__FILE__), '../fixtures')
  fixtures :all

  def setup
    ClosedBanner.destroy_all
    @banner = BannerNotification.find(1)
  end

  def test_create
    log_user('admin', 'admin')
    assert_difference 'BannerNotification.count', 1 do
      post banners_path, banner_notification: { content: 'asd',
                                                notification_type: 'info',
                                                hideable: true,
                                                time_from: Time.now - 2.days,
                                                time_to: Time.now + 2.days }
      assert_response 302
    end
  end

  def test_destroy
    log_user('admin', 'admin')
    assert_difference 'BannerNotification.count', -1 do
      delete banner_path(@banner)
      assert_response 302
    end
  end

  def test_close
    log_user('jsmith', 'jsmith')
    assert_difference 'ClosedBanner.count', 1 do
      post banners_close_path, banner_id: @banner.id, user_id_banner: User.current.id
      assert_response 200
      assert ClosedBanner.last.user, User.current
      assert ClosedBanner.last.banner_notification, @banner
    end
  end

  def test_show_all_normal
    log_user('jsmith', 'jsmith')
    get banners_show_all_path
    assert_response 200
    assert assigns(:bannerss).include?(@banner)
  end

  def test_show_all_wrong_dates
    @banner.update(time_to: (Time.now - 2.days))
    log_user('jsmith', 'jsmith')
    get banners_show_all_path
    assert_response 200
    assert_not assigns(:bannerss).include?(@banner)
  end

  def test_show_all_wrong_project
    @banner.project_id = 3; @banner.save
    log_user('jsmith', 'jsmith')
    get banners_show_all_path
    assert_response 200
    assert_not assigns(:bannerss).include?(@banner)
  end

  def test_show_all_wrong_groups
    @banner.groups << 'B Team'; @banner.save
    log_user('jsmith', 'jsmith')
    get banners_show_all_path
    assert_response 200
    assert_not assigns(:bannerss).include?(@banner)
  end

end
