class Photo < ActiveRecord::Base
  belongs_to :user
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "50x50>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :caption, presence: true
  validates :name, presence: true
  validates :photo, presence: true
  validates_with AttachmentPresenceValidator, :attributes => :photo
  validates_with AttachmentSizeValidator, :attributes => :photo, :less_than => 1.megabytes
end