require 'rails_helper'

RSpec.describe Task, type: :model do
  # This creates a list for our tests
  let(:list) { create(:list) }
  
  # This creates a task with valid attributes
  let(:valid_task) { build(:task, list: list) }

  # Test associations
  describe 'associations' do
    it { should belong_to(:list) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  # Test validations
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_inclusion_of(:status).in_array(%w[open closed]) }
  end

  # Test valid task creation
  describe 'valid task' do
    it 'is valid with valid attributes' do
      expect(valid_task).to be_valid
    end
  end

  # Test invalid task scenarios
  describe 'invalid task' do
    it 'is invalid without a name' do
      task = build(:task, name: nil, list: list)
      expect(task).not_to be_valid
      expect(task.errors[:name]).to include("can't be blank")
    end

    it 'is invalid with an invalid status' do
      task = build(:task, status: 'invalid_status', list: list)
      expect(task).not_to be_valid
      expect(task.errors[:status]).to include('is not included in the list')
    end
  end

  # Test default values
  describe 'default values' do
    it 'has a default status of open' do
      task = create(:task, list: list)
      expect(task.status).to eq('open')
    end
  end
end
