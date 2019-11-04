class User < ApplicationRecord
  has_many :events_hosted, foreign_key: 'admin_id', class_name: "Event"
  has_many :attendances
  has_many :events, through: :attendances
end
