# == Schema Information
# Schema version: 20090319140725
#
# Table name: languages
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Language < ActiveRecord::Base
  has_many :algorithm_implementations
  has_many :algorithms, :through => :algorithm_implementations
end
