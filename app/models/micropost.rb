class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  validates :image, content_type: { in: %W[image/jpeg image/gif image/png],
                                    message: "画像はjpeg,gif,png形式である必要があります！" 
                                  },
                            size: { less_than: 5.megabytes,
                                    message: "容量は5MB以内である必要があります！" }

  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [500,500])
  end
end
