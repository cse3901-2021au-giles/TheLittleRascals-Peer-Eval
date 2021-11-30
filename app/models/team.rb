class Team < ApplicationRecord
    belongs_to :projects, optional: true
    has_many :teamings, :dependent => :destroy
    has_many :users, :through => :teamings
    
end
