class AddIndexToTopics < ActiveRecord::Migration[5.1]
  def change
    add_index :topics, :title, unique: true
  end
end
