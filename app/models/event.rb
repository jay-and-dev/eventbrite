class Event < ApplicationRecord
  after_update :infos_update
  belongs_to :admin, class_name: "User"
  has_many :attendances, dependent: :destroy 
  has_many :users, through: :attendances
  has_one_attached :avatar

  validate :start_after_today?

  validate :duration_modulo_5?

  validates :title,
  presence:true,
  length: { in: 5..140 }

  validates :description,
  presence:true,
  length: { in: 20..1000 }

  validates :price,
  presence:true,
  numericality: { greater_than: 1, less_than: 1000}

  validates :location,
  presence:true

  def end_date
    return start_date + (duration*60)
  end

  private

  def start_after_today?
    errors.add(:start_date, "ne peut etre créé dans le passé") unless
      start_date.present? && start_date > Date.today
  end 

  def duration_modulo_5?
    errors.add(:duration, "doit etre positif et un multiple de 5") unless
      duration.to_i%5 == 0 && duration.to_i > 0
  end 

  def infos_update
    UserMailer.event_update(self).deliver_now
  end
end
