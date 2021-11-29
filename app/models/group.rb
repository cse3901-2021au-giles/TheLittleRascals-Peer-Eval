class Group < ApplicationRecord
    has_many :groupings, :dependent => :destroy
    has_many :users, :through => :groupings
    has_many :projects, :dependent => :destroy
end
