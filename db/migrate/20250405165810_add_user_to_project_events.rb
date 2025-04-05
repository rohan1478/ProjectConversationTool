class AddUserToProjectEvents < ActiveRecord::Migration[8.0]
  def change
    add_reference :project_events, :user, null: false, foreign_key: true
  end
end
