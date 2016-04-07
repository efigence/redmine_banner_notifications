class CreateBannerNotifications < ActiveRecord::Migration
  def change
    create_table :banner_notifications do |t|
      t.datetime :time_from
      t.datetime :time_to
      t.boolean :hideable, default: true
      t.string :notification_type, null: false
      t.text :content
      t.references :project, index: true, foreign_key: true
      t.text :groups
    end
  end
end
