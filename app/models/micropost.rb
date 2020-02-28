class Micropost < ApplicationRecord
  validates :user_id, presence: true
  validates :content, presence: true,
            length: {maximum: Settings.micropost.content_maximum_length}
  validates :image,
    content_type: {
      in: Settings.micropost.content_type,
      message: I18n.t("microposts.model.message_content_type")
    },
    size: {
      less_than: Settings.micropost.image_size_mb.megabytes,
      message: I18n.t("microposts.model.message_size")
    }
  belongs_to :user
  has_one_attached :image
  
  scope :order_microposts_desc, -> {order(created_at: :desc)}
  scope :feed, (lambda do |user_id|
    where(user_id: Relationship.following_ids(user_id))
    .or(where(user_id: user_id))
  end)

  def display_image
    image.variant resize_to_limit:
      [Settings.user.image_size_limit, Settings.user.image_size_limit]
  end
end
