class Result < ApplicationRecord
    belongs_to :polls, optional: true
end
