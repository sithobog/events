class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments
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
end
