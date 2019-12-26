class Recipe < ApplicationRecord

  belongs_to :user
  has_many :ingredients, inverse_of: :recipe, dependent: :destroy

  has_many :favorite_recipes
  has_many :favorited_by, through: :favorite_recipes, source: :user

  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
  mount_uploader :image, PhotoUploader

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :description, presence: true
  validates :category, presence: true


  validates :category, inclusion: { in: %w(Appetizer Soup Salad Pasta Dairy Dishes Fish Meat Dishes Side Dishes Dessert Other),
    message: "%{value} is not a valid category" }

 include PgSearch
  pg_search_scope :search_by_name_and_category_and_user,
    against: [ :category, :name],
    associated_against: {
      user: [ :name ]
    },
    using: {
      tsearch: { prefix: true }
    }

end
