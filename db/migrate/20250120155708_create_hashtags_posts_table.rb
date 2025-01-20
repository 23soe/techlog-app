class CreateHashtagsPostsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :hashtags_posts, id: false do |t|
      t.belongs_to :hashtag

      t.belongs_to :post

      
      t.timestamps
    end
  end
end
