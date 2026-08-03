class Community < ApplicationRecord
  has_many :selections, dependent: :destroy
  has_many :contents, through: :selections

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true,
                   format: { with: /\A[a-z0-9\-]+\z/, message: "only lowercase letters, numbers, and hyphens" }

  def to_param
    slug
  end
end
