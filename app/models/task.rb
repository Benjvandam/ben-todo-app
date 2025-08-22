class Task < ApplicationRecord
  belongs_to :list
  has_many :comments, dependent: :destroy
  validates :name, presence: true
  validates :status, inclusion: { in: %w[open closed] }
end
