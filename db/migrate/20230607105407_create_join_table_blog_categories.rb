class CreateJoinTableBlogCategories < ActiveRecord::Migration[7.0]
  def change
    create_join_table :blogs, :categories do |t|
      t.index [:blog_id, :category_id]
      t.index [:category_id, :blog_id]
    end
  end
end
