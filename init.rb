require 'banner_application_hooks'

Redmine::Plugin.register :redmine_banner_notifications do
  name 'Redmine Banner Notifications plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  menu :top_menu,
       :banner_notifications, {controller: 'banners', action: 'index'},
       caption: 'Banners', :after => :help,
       :if => proc { Setting.plugin_redmine_banner_notifications['banner_admins'].map(&:to_i).include?(User.current.try(:id)) }

  menu :account_menu,
       :banner_envelope, {controller: 'banners', action: 'show_all'},
       caption: '', first: true

  settings default: { 'banner_admins' => [] }, partial: 'settings/banner_notifications_settings'

  ActionDispatch::Callbacks.to_prepare do
    ApplicationController.send(:include, RedmineBannerNotifications::Patches::ApplicationControllerPatch)
  end
end
