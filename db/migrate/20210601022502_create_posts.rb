class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title,  null: false
      t.text :catch_copy, null: false
      t.text :concept, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
