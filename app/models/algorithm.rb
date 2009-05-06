# == Schema Information
# Schema version: 20090309210721
#
# Table name: algorithms
#
#  id                   :integer         not null, primary key
#  code                 :string(255)
#  name                 :string(255)
#  description          :text
#  user_id              :integer
#  created_at           :datetime
#  updated_at           :datetime
#  sources_file_name    :string(255)
#  sources_content_type :string(255)
#  sources_file_size    :integer
#

class Algorithm < ActiveRecord::Base
  has_attached_file :sources, :path => ":rails_root/public/system/algorithms/:id/:basename.:extension"

  has_and_belongs_to_many :computers
  belongs_to :user
  has_many :algorithm_implementations
end
