class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :content, null:false
      t.references :user, foreign_key: true, null: false # 外部キー (User)
      t.timestamps
    end
  end
end
