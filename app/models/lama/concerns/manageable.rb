module Lama
  module Concerns
    # Adds some associations for models that can be managed by users
    module Manageable
      extend ActiveSupport::Concern

      included do
        # User that has created this model
        belongs_to :creator, class_name: User, foreign_key: :created_user_id

        # User that has last updated this model
        belongs_to :updater, class_name: User, foreign_key: :updated_user_id
      end

      module ClassMethods
      end
    end
  end
end
