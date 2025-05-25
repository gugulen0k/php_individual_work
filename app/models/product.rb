class Product < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :image_url, presence: true

  scope :featured, -> { where(featured: true) }
  scope :active, -> { where(active: true) }
  
  def self.search(query)
    if query.present?
      where('name ILIKE :query OR description ILIKE :query', query: "%#{query}%")
    else
      all
    end
  end
end 