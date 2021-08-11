class Event < ApplicationRecord
  has_many :messages
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events, dependent: :destroy

  validates :title, {presence:true, length:{maximum: 20}}
  validates :recruting_count, {presence:true}
  validates :event_date, {presence:true}
  validates :comment, {presence:true, length:{maximum: 100}}
  validates :run_location, {presence:true, length:{maximum: 20}}
  validates :meeting_place, {presence:true, length:{maximum: 20}}

  validate :day_after_today

  def day_after_today
    if event_date.present?
      if event_date < Date.today
        errors.add(:event_date, 'は、明日以降の日付をしていしてください。')
      end
    else
      errors.add(:event_date, 'を入力してください')
    end
  end
  
  def self.search(keyword,date)
    if date.present?
      where(["event_date > ?", "#{date.in_time_zone.beginning_of_day}"]).where(["title like? OR meeting_place like? OR comment like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
    else
      where(["title like? OR meeting_place like? OR comment like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
    end
  end
end
