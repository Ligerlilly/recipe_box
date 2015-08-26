class RemoveRecipeIdFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :recipe_id
  end
end
