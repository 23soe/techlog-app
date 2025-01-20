class Post < ApplicationRecord

    belongs_to :user

    validates :title, presence: true, length: { maximum: 100 }
    validates :content, presence: true, length: { maximum: 100 }
    has_and_belongs_to_many :hashtags

    before_save :parse_and_save_hashtags
    def parse_and_save_hashtags
        #matches = content.scan(/#\w+/)  //only English
        matches = content.scan(/#[\p{Word}]+/u)
        return if matches.empty?

        matches.flatten.each do |tag|
            hashtag =  Hashtag.find_or_create_by(tag: tag)
            hashtags << hashtag unless hashtags.include?(hashtag)
            puts "Created hashtag: #{hashtag.tag}"
        end
        puts "Post hashtags after save: #{self.hashtags.map(&:tag)}"
    end
end
