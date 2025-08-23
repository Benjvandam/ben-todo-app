require 'rails_helper'

RSpec.describe List, type: :model do
  # Test associations
  describe 'associations' do
    it { should have_many(:tasks).dependent(:destroy) }
  end

  # Test validations
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  # Test valid list creation
  describe 'valid list' do
    it 'is valid with valid attributes' do
      list = build(:list)
      expect(list).to be_valid
    end
  end

  # Test invalid list scenarios
  describe 'invalid list' do
    it 'is invalid without a name' do
      list = build(:list, name: nil)
      expect(list).not_to be_valid
      expect(list.errors[:name]).to include("can't be blank")
    end
  end

  # Test tasks association
  describe 'tasks association' do
    it 'can have multiple tasks' do
      list = create(:list)
      task1 = create(:task, list: list)
      task2 = create(:task, list: list)
      
      expect(list.tasks).to include(task1, task2)
      expect(list.tasks.count).to eq(2)
    end

    it 'destroys associated tasks when list is destroyed' do
      list = create(:list)
      task = create(:task, list: list)
      
      expect { list.destroy }.to change(Task, :count).by(-1)
    end
  end
end
