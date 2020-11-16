class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true
  validates :name, presence: true
  validates :user_id, presence: true
end
