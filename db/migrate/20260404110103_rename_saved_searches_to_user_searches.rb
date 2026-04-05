class RenameSavedSearchesToUserSearches < ActiveRecord::Migration[8.1]
  def change
    rename_table :saved_searches, :user_searches
  end
end
