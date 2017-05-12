class Store < ActiveRecord::Base
  has_many :inventories
  has_many :models, through: :inventory

  validates :name, :presence => true
end
