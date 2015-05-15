# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  bonus      :boolean          default("f")
#  lyrics     :text
#  album_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base
  validates :title, :album_id, presence: true
  validates :bonus, inclusion: { in: [true, false] }
  validates :lyrics, length: { maximum: 10000 }
  validates :title, length: { minimum: 1, maximum: 80 }

  belongs_to :album
  has_one :band, through: :album
  has_many :notes
end
