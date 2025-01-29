class Post < ApplicationRecord
    belongs_to :user
    belongs_to :category

    has_and_belongs_to_many :tags, join_table: :posts_tags
    has_many :comments, dependent: :destroy
    
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
        matches = content.scan(/[＃#][\p{Word}\p{Alnum}_]+/u)
        return if matches.empty?
        
        matches.flatten.each do |tag_name|
            normalized_tag_name = tag_name.unicode_normalize(:nfkc).gsub('＃', '#')
        
            begin
            tag = Tag.find_or_create_by(name: normalized_tag_name)
        
            if tags.include?(tag)
            else
                tags << tag
            end
            rescue => e
            end
        end
    end

    def normalize_content
        self.content = content.gsub('＃', '#') if content.present?
      end
end
