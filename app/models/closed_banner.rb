class ClosedBanner < ActiveRecord::Base
  unloadable

  belongs_to :user
  belongs_to :banner_notification

  validates :user_id, uniqueness: { scope: :banner_notification_id }
end
