class Tag < ApplicationRecord
    has_and_belongs_to_many :posts, join_table: :posts_tags

    validates :name, presence: true, uniqueness: true
end
