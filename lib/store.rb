class Store < ActiveRecord::Base
  has_many :inventories
  has_many :models, through: :inventories

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
