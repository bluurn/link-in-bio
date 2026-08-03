class Content < ApplicationRecord
  has_many :selections, dependent: :destroy
  has_many :communities, through: :selections

  enum :kind, { course: 0, event: 1, playlist: 2 }

  validates :title,   presence: true
  validates :creator, presence: true
  validates :url, presence: true,
                  format: { with: /\Ahttps?:\/\/\S+\z/i, message: "must be a valid http or https URL" }
  validates :price,   numericality: { greater_than_or_equal_to: 0 }
  validates :slug,    presence: true, uniqueness: true

  before_validation :generate_slug, if: -> { slug.blank? }

  scope :by_kind, ->(k) { k.present? ? where(kind: k) : all }
  scope :search,  ->(q) { q.present? ? where("title ILIKE ?", "%#{q}%") : all }

  def to_param
    self[:slug]
  end

  private

  def generate_slug
    return if title.blank?

    base = title.parameterize
    candidate = base
    counter = 2
    while Content.where(slug: candidate).where.not(id: id).exists?
      candidate = "#{base}-#{counter}"
      counter += 1
    end
    self.slug = candidate
  end
end
