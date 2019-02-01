class AddUniqToAccountSlug < ActiveRecord::Migration[5.2]
  def change
    add_index :accounts, :slug, unique: true
  end
end
