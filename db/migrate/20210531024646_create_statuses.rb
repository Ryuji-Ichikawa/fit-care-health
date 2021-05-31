class CreateStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :statuses do |t|
      t.references :user, foreign_key: true
      t.text   :text
      t.timestamps
    end
  end
end
