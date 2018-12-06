class Project < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  validates :title, presence: true, uniqueness: true
  validates :title, length: { minimum: 6 }
  validates :description, presence: true
  validates :description, length: { minimum: 50 }
  validates :price, presence: true
  validates :price, numericality: true
  validates :target, presence: true
  validates :target, numericality: true
  validates :images, presence: true
end
