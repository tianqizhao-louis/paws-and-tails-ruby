class Breeder < ApplicationRecord
  validates :name, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :price_level, presence: true, format: {with: /\$+/}
  validates :address, presence: true
  validates :email, presence: true, email: true
  has_many :animals, dependent: :destroy

  def self.get_animals(breeder_id)
    animals = Animal.where(:breeder_id => breeder_id)
    return animals
  end

  def self.get_city_all
    Breeder.distinct.pluck(:city)
  end

  def self.get_country_all
    Breeder.distinct.pluck(:country)
  end
end
