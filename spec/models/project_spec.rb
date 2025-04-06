require 'rails_helper'

RSpec.describe Project, type: :model do
  # Associations
  it { should have_many(:project_events).dependent(:destroy) }

  # Enum validation
  it { should define_enum_for(:status).with_values(pending: 0, in_progress: 1, completed: 2) }

  # Validations
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(255) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:description) }
  it { should validate_length_of(:description).is_at_most(255) }

  # Nested Attributes - Testing accepts_nested_attributes_for
  context 'accepts_nested_attributes_for' do
    it 'accepts nested attributes for project_events' do
      project = FactoryBot.build(:project)
      user = FactoryBot.build(:user)

      project.project_events_attributes = [ { event_type: 'status_change', old_status: 'pending', new_status: 'completed', user: user } ]
      expect(project).to be_valid
    end

    it 'rejects all_blank project_events attributes' do
      project = FactoryBot.build(:project)
      project.project_events_attributes = [ {} ]
      expect(project).to be_valid
    end
  end

  describe 'status enum' do
    it 'should have the correct enum values' do
      expect(Project.statuses[:pending]).to eq(0)
      expect(Project.statuses[:in_progress]).to eq(1)
      expect(Project.statuses[:completed]).to eq(2)
    end
  end
end
