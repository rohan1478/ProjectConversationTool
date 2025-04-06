class Project < ApplicationRecord
    has_many :project_events, dependent: :destroy
    enum :status, { pending: 0, in_progress: 1, completed: 2 }

    accepts_nested_attributes_for :project_events, allow_destroy: false, reject_if: :all_blank

    validates :title, presence: true, length: { maximum: 255 } 
    validates :status, presence: true 
    validates :description, presence: true, length: { maximum: 255 }
end
