class Issue < ApplicationRecord
    
    has_attached_file :file, :styles => { :small => "150x150>" }, default_url: "http://clipart-library.com/image_gallery/267356.png"
    validates_attachment_content_type :file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

    
    ALL_PRIORITIES = ["trivial", "minor", "major", "critical", "blocker"]
    
    validates_inclusion_of :priority, :in => ALL_PRIORITIES
    
    
    ALL_TYPES = ["bug", "enhancement", "proposal", "task"]
    
    validates_inclusion_of :kind, :in => ALL_TYPES  
    
    belongs_to :user, class_name: 'User', foreign_key: 'user_id'
    belongs_to :assignee, optional: true, :class_name => 'User', foreign_key: 'assignee_id'
    has_many :comments, dependent: :destroy
    has_many :votes, dependent: :destroy
    has_many :watches, dependent: :destroy
end
