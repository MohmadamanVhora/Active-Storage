class User < ApplicationRecord
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :show, resize_to_limit: [250, 250]
  end

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :phone_no, presence: true, length: { is: 10 }
  validates :avatar, presence: true
  validate :validate_avatar

  private

  def validate_avatar
    return unless avatar.attached?
    return if avatar.blob.content_type.in?(%w[image/jpeg image/png])

    errors.add(:avatar, 'must be a JPG or PNG file')
  end
end
