class Model < ActiveRecord::Base
  belongs_to :brand
  has_many :inventories
  has_many :stores, through: :inventories

  validates :price, presence: true
  validates :name, {
    presence: true,
    uniqueness: true,
    length: { :maximum => 100 }
  }

  before_save(:capitalize_words)

  private

  def capitalize_words
    words = self.name.split(' ')
    words.each do |word|
      word.capitalize!
    end
    self.name = words.join(' ')
  end

end
