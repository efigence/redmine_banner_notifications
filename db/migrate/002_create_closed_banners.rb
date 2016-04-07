class CreateClosedBanners < ActiveRecord::Migration
  def change
    create_table :closed_banners do |t|
      t.references :user, index: true, foreign_key: true
      t.references :banner_notification, index: true, foreign_key: true
    end
  end
end
