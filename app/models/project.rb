class Project < ApplicationRecord
    belongs_to :groups, optional: true
    has_many :teams, :dependent => :destroy
    has_many :polls, :dependent => :destroy
end
