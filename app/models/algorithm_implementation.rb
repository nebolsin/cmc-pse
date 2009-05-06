# == Schema Information
# Schema version: 20090319140725
#
# Table name: algorithm_implementations
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  description          :text
#  algorithm_id         :integer
#  language_id          :integer
#  user_id              :integer
#  sources_file_name    :string(255)
#  sources_content_type :string(255)
#  sources_file_size    :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class AlgorithmImplementation < ActiveRecord::Base
  has_attached_file :sources, :path => ":rails_root/public/system/implementations/:id/:basename.:extension"
  belongs_to :algorithm
  belongs_to :language
end
