class Model < ActiveRecord::Base
  belongs_to :brand
  has_many :inventories
  has_many :stores, through: :inventories

  validates :name, :price, presence: true
end
