class Event < ActiveRecord::Base
  has_many :comments
  has_many :invites, class_name: 'EventInvite'
  belongs_to :user
  
  validates :date, :place, :purpose, :description, presence: true
  validates :place, :purpose, length: { maximum: 150 }
  validates :description, length: { maximum: 500 }
  validates :user, presence: true
  validate :check_date, if: :date

  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  def check_date
    errors.add(:date, :invalid, message: "must be in future!") if date < DateTime.now
  end

  def add_picture(picture_64, picture_name)
    picture_data                   = Paperclip.io_adapters.for(picture_64)
    picture_data.original_filename = picture_name
    self.picture = picture_data
  end

  def self.filter(params = {}, user = nil)

    events_ids = EventInvite.where(user_id: user.id).pluck(:event_id)

    query ||= where('id IN (?) or user_id = ?', events_ids, user.id)

    if params[:due] && is_numeric?(params[:due])
      specific_day = Time.at(params[:due].to_i).to_date
      query = query.where(date: specific_day.beginning_of_day..specific_day.end_of_day)
    end

    if params[:interval] && valid_interval?(params[:interval])
      interval = get_interval(params[:interval])
      query = query.where(date: DateTime.now..(DateTime.now + interval))
    end
    
    query.distinct
  end

  protected

  def self.is_numeric?(value)
    value = value.to_i
    value != 0 && (value.is_a? Numeric)
  end

  def self.valid_interval?(interval)
    /([\d]+)([dwmy]{1})/.match(interval)
  end

  # generate interval from string
  def self.get_interval(interval)
    matched_groups = /([\d]+)([dwmy]{1})/.match(interval)
    number = matched_groups[1].to_i
    time = case matched_groups[2]
      when 'd' then :days
      when 'm' then :months
      when 'y' then :years
      when 'w' then :weeks
      else :seconds
    end
    number.send(time)
  end
end
