class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes, dependent: :destroy

  has_many :favorite_recipes
  has_many :favorites, through: :favorite_recipes, source: :recipe

  mount_uploader :photo, PhotoUploader

  # validates :photo, presence: true
end
