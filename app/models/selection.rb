class Selection < ApplicationRecord
  belongs_to :community
  belongs_to :content

  validates :content_id, uniqueness: { scope: :community_id }
end
