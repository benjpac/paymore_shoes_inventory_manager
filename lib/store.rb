class Store < ActiveRecord::Base
  has_many :inventories
  has_many :models, through: :inventories

  validates :name, presence: true
end
