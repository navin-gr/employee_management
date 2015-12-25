class Employee < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :designation, presence: true
  validates :mentor, presence: true
  mount_uploader :profile_image, ProfileImageUploader

  
end
