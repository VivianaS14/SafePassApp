class Entry < ApplicationRecord
  belongs_to :user

  validates :name, :username, :password, presence: true
  validate :url_must_be_valid

  # Active Record Encryption
  encrypts :username, deterministic: true
  encrypts :password

  scope :search_name, ->(name) {
    # Run SQL fot search, active record where method to filter records from entries table based on the name column
    where("entries.name ILIKE ?", "%#{name}%") if name.present?
    # ILIKE to perform a case insensitive SQL pattern match
  }

  # This is a class method
  def self.search(name)
    search_name(name).order(:name)
  end

  private

  def url_must_be_valid
    unless url.include?("http" || "https")
      errors.add(:url, "Url must be valid")
    end
  end
end
