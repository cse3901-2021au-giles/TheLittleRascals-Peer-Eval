class User < ApplicationRecord
    has_secure_password
    has_many :groupings, :dependent => :destroy
    has_many :groups, :through => :groupings
    has_many :teamings, :dependent => :destroy
    has_many :teams, :through => :teamings
    has_many :polls, :through => :pollings
    has_many :pollings, :dependent => :destroy
end
