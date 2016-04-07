require File.expand_path('../../test_helper', __FILE__)

class ApplicationControllerTest < Redmine::IntegrationTest
  self.fixture_path = File.join(File.dirname(__FILE__), '../fixtures')
  fixtures :all

  def setup
    @banner = BannerNotification.find(1)
  end

  def test_not_assign_banners_for_anonymous
    get banners_show_all_path
    assert_not assigns(:banners)
  end

  def test_banners_includes_proper_banner
    log_user('jsmith', 'jsmith')
    get banners_show_all_path
    assert assigns(:banners).include?(@banner)
  end

  def test_banners_does_not_include_with_wrong_dates
    @banner.update(time_to: (Time.now - 2.days))
    log_user('jsmith', 'jsmith')
    get banners_show_all_path
    assert_not assigns(:banners).include?(@banner)
  end

  def test_banners_includes_with_proper_groups
    @banner.groups << 'A Team'; @banner.save
    log_user('jsmith', 'jsmith')
    get banners_show_all_path
    assert assigns(:banners).include?(@banner)
  end

  def test_banners_does_not_include_with_wrong_groups
    @banner.groups << 'B Team'; @banner.save
    log_user('jsmith', 'jsmith')
    get banners_show_all_path
    assert_not assigns(:banners).include?(@banner)
  end

  def test_banners_includes_with_proper_project
    @banner.project_id = 1; @banner.save
    log_user('jsmith', 'jsmith')
    get banners_show_all_path
    assert assigns(:banners).include?(@banner)
  end

  def test_banners_does_not_include_with_wrong_project
    @banner.project_id = 3; @banner.save
    log_user('jsmith', 'jsmith')
    get banners_show_all_path
    assert_not assigns(:banners).include?(@banner)
  end

  def test_banners_does_not_include_closed
    ClosedBanner.create(user_id: User.find_by(login: 'jsmith').id, banner_notification_id: @banner.id)
    log_user('jsmith', 'jsmith')
    get banners_show_all_path
    assert_not assigns(:banners).include?(@banner)
  end

  private

  def allow_user user
    user.admin = true
    user.save
  end
end
