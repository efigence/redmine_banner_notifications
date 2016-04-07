require_dependency 'application_controller'

module RedmineBannerNotifications
  module Patches
    module ApplicationControllerPatch

      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable

          before_action :get_banner_notifications

          def get_banner_notifications
            if User.current.logged?
              @banners = BannerNotification.good_time.select do |bann|
                if bann.groups == [''] || ((User.current.groups.map { |gr| gr.lastname }) & (bann.groups - [nil, ''])).size > 0 || bann.groups == []
                  if bann.project_id.nil? || bann.project.users.include?(User.current)
                    bann unless bann.closed_banners.find_by(user: User.current)
                  end
                end
              end
            end
          end
        end
      end

      module InstanceMethods
        # ..
      end
    end
  end
end
