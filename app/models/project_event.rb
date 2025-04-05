class ProjectEvent < ApplicationRecord
    belongs_to :user
    belongs_to :project
  
    enum :event_type, { comment: "comment", status_change: "status_change" }
  end