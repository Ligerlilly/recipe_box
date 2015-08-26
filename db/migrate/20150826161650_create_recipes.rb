class CreateRecipes < ActiveRecord::Migration
  def change
    create_table(:recipes) do |t|
      t.column(:name, :string)
      t.column(:instructions, :text)
      t.column(:ingredients, :string)

      t.timestamps()
    end
  end
end
