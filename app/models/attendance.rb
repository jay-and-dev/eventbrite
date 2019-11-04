class Attendance < ApplicationRecord
  after_create :inscription_send
  belongs_to :user
  belongs_to :event

  def inscription_send
    UserMailer.new_inscription(self).deliver_now
  end
end
