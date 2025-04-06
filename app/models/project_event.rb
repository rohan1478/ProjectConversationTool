class ProjectEvent < ApplicationRecord
    belongs_to :user
    belongs_to :project

    enum :event_type, { comment: "comment", status_change: "status_change" }

    with_options if: -> { event_type == "status_change" } do
        validates :old_status, presence: true
        validates :new_status, presence: true
    end
end
