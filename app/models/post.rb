class Post < ApplicationRecord
    belongs_to :user
    belongs_to :category

    has_and_belongs_to_many :tags, join_table: :post_tags
  
    validates :title, presence: true, length: { maximum: 100 }
    validates :content, presence: true, length: { maximum: 100 }
    validates :category_id, presence: true

    # ハッシュタグをリンクとして変換
    def content_with_links
        content.gsub(/([＃#][\p{Word}]+)/u) do |match|
        normalized_tag_name = match.gsub('＃', '#') 
        tag_name = normalized_tag_name.delete('#') # ハッシュタグ名を取得
        "<a href='/tags/#{tag_name}' class='highlight-tag'>#{match}</a>"
        end.html_safe
    end

    # 保存前にタグを解析して保存
    before_save :parse_and_save_tags, :normalize_content

    private

    # タグの解析と保存
    def parse_and_save_tags
        # content から全角・半角のハッシュタグを抽出
        # puts "Processing content: #{content.inspect}" # デバッグ用
        matches = content.scan(/[＃#][\p{Word}\p{Alnum}_]+/u)
        # puts "Extracted matches: #{matches.inspect}"
        return if matches.empty?
        
        matches.flatten.each do |tag_name|
            # puts "Processing tag # #{tag_name.inspect}" # デバッグ用
            normalized_tag_name = tag_name.unicode_normalize(:nfkc).gsub('＃', '#')
            # puts "Normalized tag name: #{normalized_tag_name.inspect}" # デバッグ用
        
            begin
            tag = Tag.find_or_create_by(name: normalized_tag_name)
            # puts "Found or created tag: #{tag.inspect}" # デバッグ用
        
            if tags.include?(tag)
                # puts "Tag already associated with this post: #{tag.name}" # デバッグ用
            else
                tags << tag
                # puts "Tag associated with this post: #{tag.name}" # デバッグ用
            end
            rescue => e
            # puts "Error processing tag: #{e.message}" # デバッグ用
            end
        end
        
        # puts "Final tags for this post: #{self.tags.map(&:name)}" # デバッグ用
    end

    def normalize_content
        self.content = content.gsub('＃', '#') if content.present?
      end
end
