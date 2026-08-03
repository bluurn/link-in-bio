class Content < ApplicationRecord
  has_many :selections, dependent: :destroy
  has_many :communities, through: :selections

  enum :kind, { course: 0, event: 1, playlist: 2 }

  validates :title,   presence: true
  validates :creator, presence: true
  validates :url, presence: true,
                  format: { with: /\Ahttps?:\/\/\S+\z/i, message: "must be a valid http or https URL" }
  validates :price,   numericality: { greater_than_or_equal_to: 0 }

  scope :by_kind, ->(k) { k.present? ? where(kind: k) : all }
  scope :search,  ->(q) { q.present? ? where("title ILIKE ?", "%#{q}%") : all }
end
