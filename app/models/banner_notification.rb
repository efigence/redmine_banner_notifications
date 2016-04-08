class BannerNotification < ActiveRecord::Base
  unloadable
  attr_accessible :content, :time_from, :time_to, :hideable, :notification_type, :project_id, :groups, :active

  serialize :groups, Array

  validates :content, length: { minimum: 10 }
  validates :notification_type, inclusion: { in: ['info', 'warning', 'error'] }
  validate :valid_date_range_required

  belongs_to :project
  has_many :closed_banners, dependent: :destroy

  scope :good_time, -> { includes(:closed_banners).where('time_from < ? AND ? < time_to', Time.now, Time.now).where(active: true) }

  def valid_date_range_required
    if (time_from && time_to) && (time_to <= time_from)
      errors.add("'Time to' must be later than 'Time from' - ")
    end
  end
end
