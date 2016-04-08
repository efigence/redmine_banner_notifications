require 'banner_application_hooks'

Redmine::Plugin.register :redmine_banner_notifications do
  name 'Redmine Banner Notifications plugin'
  author 'Jan Lachowicz'
  description 'Plugin allows admins and chosen people to create notifications, that will show as a banner to specific users.'
  version '0.0.1'
  url 'https://github.com/efigence/redmine_banner_notifications'
  author_url 'https://github.com/jafffmen'

  menu :top_menu,
       :banner_notifications, {controller: 'banners', action: 'index'},
       caption: 'Banners', :after => :help,
       :if => proc { Setting.plugin_redmine_banner_notifications['banner_admins'].map(&:to_i).include?(User.current.try(:id)) || User.current.admin? }

  menu :account_menu,
       :banner_envelope, {controller: 'banners', action: 'show_all'},
       caption: '', first: true,
       :if => proc { User.current.logged? }

  settings default: { 'banner_admins' => [] }, partial: 'settings/banner_notifications_settings'

  ActionDispatch::Callbacks.to_prepare do
    ApplicationController.send(:include, RedmineBannerNotifications::Patches::ApplicationControllerPatch)
  end
end
