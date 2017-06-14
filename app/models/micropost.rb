class Micropost < ApplicationRecord
  belongs_to :user

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.content_size}
  validate  :picture_size

  scope :sort_by_created_at, ->{order created_at: :desc}
  scope :feed_load, ->id{where user_id: id}

  private

  def picture_size
    if picture.size > Settings.micropost.size_picture.megabytes
      errors.add :picture, I18n.t("micropost.less_size")
    end
  end
end
