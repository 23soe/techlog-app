require 'rails_helper'

describe Post do
  before { @user = create(:user) } # 事前にユーザーを作成

  let(:title) { 'テストタイトル' }
  let(:content) { 'テスト#本文' }
  let(:user_id) { @user.id } # 作成したユーザーのIDを外部キーに設定

  describe 'バリデーションの検証' do
    let(:post) { Post.new(title: title, content: content, user_id: user_id) }

    context '正常系' do
      it '有効である' do
        expect(post.valid?).to be(true)
      end
    end

    context '異常系' do
      context 'titleが空の場合' do
        let(:title) { nil }
        it '無効である' do
          expect(post.valid?).to be(false)
          expect(post.errors[:title]).to include('が入力されていません。')
        end
      end

      context 'titleが100文字を超える場合' do
        let(:title) { 'あ' * 101 }
        it '無効である' do
          expect(post.valid?).to be(false)
        end
      end

      context 'contentが空の場合' do
        let(:content) { nil }
        it '無効である' do
          expect(post.valid?).to be(false)
          expect(post.errors[:content]).to include('が入力されていません。')
        end
      end

      context 'contentが1000文字を超える場合' do
        let(:content) { 'あ' * 1001 }
        it '無効である' do
          expect(post.valid?).to be(false)
        end
      end

      context 'user_idが空の場合' do
        let(:user_id) { nil }
        it '無効である' do
          expect(post.valid?).to be(false)
          expect(post.errors[:user]).to include('が入力されていません。')
        end
      end
    end
  end

  describe 'Postが持つ情報の検証' do
    before { create(:post, title: title, content: content, user_id: user_id) } # Post を作成

    subject { described_class.first }

    it 'Postの属性値を返す' do
      expect(subject.title).to eq('テストタイトル')
      expect(subject.content).to eq('テスト#本文')
      expect(subject.user_id).to eq(@user.id)
    end
  end

  describe "saving hashtags" do

    context "when there are no hashtags in the content" do
      it "does not create any hashtags" do
        expect do
          Post.create(title: title, content: "I am Jeong Soee", user_id: user_id)
        end.not_to change { Hashtag.count }
      end
    end
    
    context "when there are hashtags in the content" do
      it "creates hashtags" do
        expect do
          Post.create(title: title, content: "I am #Jeong #Soee", user_id: user_id)
        end.to change { Hashtag.count }.by(2)
      end
    end
    context "when there are duplicate hastags in the content" do
      it "does not create extra hashtags if already in the database table" do
        Hashtag.create(tag: "#Jeong")
        expect do
          Post.create(title: title, content: "I am #Jeong #Soee", user_id: user_id)
        end.to change { Hashtag.count }.by(1)
      end
    end
  end
end
