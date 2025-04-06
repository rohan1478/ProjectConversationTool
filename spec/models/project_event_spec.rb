require 'rails_helper'

RSpec.describe ProjectEvent, type: :model do
  # Associations
  it { should belong_to(:user) }
  it { should belong_to(:project) }

  # Validations
  context 'when event_type is status_change' do
    it 'is valid with valid old_status and new_status' do
      project_event = FactoryBot.build(:project_event, event_type: 'status_change', old_status: 'pending', new_status: 'completed')
      expect(project_event).to be_valid
    end

    it 'is not valid without old_status' do
      project_event = FactoryBot.build(:project_event, event_type: 'status_change', old_status: nil, new_status: 'completed')
      expect(project_event).to_not be_valid
      expect(project_event.errors[:old_status]).to include("can't be blank")
    end

    it 'is not valid without new_status' do
      project_event = FactoryBot.build(:project_event, event_type: 'status_change', old_status: 'pending', new_status: nil)
      expect(project_event).to_not be_valid
      expect(project_event.errors[:new_status]).to include("can't be blank")
    end
  end

  context 'when event_type is comment' do
    it 'is valid without old_status and new_status' do
      project_event = FactoryBot.build(:project_event, event_type: 'comment', old_status: nil, new_status: nil)
      expect(project_event).to be_valid
    end
  end
end
