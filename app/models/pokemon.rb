class Pokemon < ApplicationRecord
  belongs_to :type_1, :class_name => "Type"
  belongs_to :type_2, :class_name => "Type"
end
