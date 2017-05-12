class Inventory < ActiveRecord::Base
  belongs_to :store
  belongs_to :model
end
