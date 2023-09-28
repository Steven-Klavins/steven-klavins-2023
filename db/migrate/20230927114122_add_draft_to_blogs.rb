class AddDraftToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :draft, :boolean, default: false
    Blog.update_all(draft: false)
  end
end
