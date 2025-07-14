class Entry < ApplicationRecord
  belongs_to :user

  validates :name, :username, :password, presence: true
  validate :url_must_be_valid

  # Active Record Encryption
  encrypts :username, deterministic: true
  encrypts :password

  private

  def url_must_be_valid
    unless url.include?("http" || "https")
      errors.add(:url, "Url must be valid")
    end
  end
end
