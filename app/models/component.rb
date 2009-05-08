# == Schema Information
# Schema version: 20090506170628
#
# Table name: components
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  description          :text
#  user_id              :string(255)
#  sources_file_name    :string(255)
#  sources_content_type :string(255)
#  sources_file_size    :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class Component < ActiveRecord::Base

  belongs_to :user

  has_and_belongs_to_many :computers
  has_many :simulations


  has_attached_file :sources, :path => ":rails_root/public/system/components/:id/:id.:extension"

  def is_finished?
    status == 'F'
  end
end
