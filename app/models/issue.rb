class Issue < ApplicationRecord
    
    ALL_PRIORITIES = ["trivial", "minor", "major", "critical", "blocker"]
    
    validates_inclusion_of :priority, :in => ALL_PRIORITIES
    
    
    ALL_TYPES = ["bug", "enhancement", "proposal", "task"]
    
    validates_inclusion_of :kind, :in => ALL_TYPES  
    

    #belongs_to :user, optional: true, foreign_key: 'assignee'
    has_many :comments, dependent: :destroy

end
