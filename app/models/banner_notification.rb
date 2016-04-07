class BannerNotification < ActiveRecord::Base
  unloadable

  serialize :groups, Array

  validates :notification_type, inclusion: { in: ['info', 'warning', 'error'] }

  belongs_to :project
  has_many :closed_banners, dependent: :destroy

  scope :good_time, -> { includes(:closed_banners).where('time_from < ? AND ? < time_to', Time.now, Time.now) }
end
