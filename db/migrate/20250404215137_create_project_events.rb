class CreateProjectEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :project_events do |t|
      t.references :project, null: false, foreign_key: true
      t.string :event_type, null: false # enum: "comment" or "status_change"

      t.text :content                   # used if event_type == "comment"
      t.string :old_status              # used if event_type == "status_change"
      t.string :new_status              # used if event_type == "status_change"

      t.timestamps
    end
  end
end
