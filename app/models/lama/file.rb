module Lama
  class File < ActiveRecord::Base

    # User that has created this file
    belongs_to :creator, class_name: User, foreign_key: :created_user_id

    # User that has last updated this file
    belongs_to :updater, class_name: User, foreign_key: :updated_user_id

  end
end
