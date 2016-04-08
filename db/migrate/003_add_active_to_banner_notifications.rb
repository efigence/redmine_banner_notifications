class AddActiveToBannerNotifications < ActiveRecord::Migration
  def up
    add_column :banner_notifications, :active, :boolean, default: false
  end

  def down
    remove_column :banner_notifications, :active, :boolean
  end
end
