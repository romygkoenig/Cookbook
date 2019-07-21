class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients, inverse_of: :recipe, dependent: :destroy
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
  mount_uploader :image, PhotoUploader

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :description, presence: true
  validates :category, presence: true
end
