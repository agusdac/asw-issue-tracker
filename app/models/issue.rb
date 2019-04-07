class Issue < ApplicationRecord
    
    ALL_PRIORITIES = ["trivial", "minor", "major", "critical", "blocker"]
    
    validates_inclusion_of :priority, :in => ALL_PRIORITIES
    
    
    ALL_TYPES = ["bug", "enhancement", "proposal", "task"]
    
    validates_inclusion_of :kind, :in => ALL_TYPES  
    
    belongs_to :user, class_name: 'User', foreign_key: 'user_id'
    belongs_to :assignee, optional: true, class_name: 'User', foreign_key: 'assignee_id'
    has_many :comments, dependent: :destroy
end
