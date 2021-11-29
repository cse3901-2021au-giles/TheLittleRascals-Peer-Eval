class Poll < ApplicationRecord
    belongs_to :projects, optional: true
    has_many :results, :dependent => :destroy
    has_many :pollings, :dependent => :destroy
    has_many :users, :through => :pollings
end
