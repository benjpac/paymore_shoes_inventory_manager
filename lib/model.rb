class Model < ActiveRecord::Base
  belongs_to :model
  has_many :inventories
  has_many :stores, through: :inventories

  validates :name, :presence => true
end
