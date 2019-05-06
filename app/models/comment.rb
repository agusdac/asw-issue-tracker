class Comment < ApplicationRecord
  has_attached_file :file, :styles => { :small => "150x150>" }, default_url: "http://clipart-library.com/image_gallery/267356.png"
  validates_attachment_content_type :file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  belongs_to :issue
  belongs_to :user, optional: true
end
