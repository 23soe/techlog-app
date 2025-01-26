document.addEventListener('DOMContentLoaded', () => {
    const searchApp = Vue.createApp({
      data() {
        return {
          searchQuery: '', //  検索ワード
          filteredPosts: [], // フィルタリングされたポストデータ
          errorMessage: '',
        };
      },
      methods: {
        fetchPostsByTag() {
          if (!this.searchQuery.trim()) {
            // 検索ワードがない場合は空配列に設定
            this.errorMessage = "入力してください";
            this.filteredPosts = [];
            return;
          }
  
          axios
            .get(`/tags/posts_by_tag?tag=${encodeURIComponent(this.searchQuery)}`)
            .then((response) => {
              this.filteredPosts = response.data; // 検索結果を設定
              this.errorMessage = response.data.length ? '' : 'データがありません。';
            })
            .catch((error) => {
                console.error('Error fetching posts by tag', error);
                this.errorMessage = 'エラーが発生しました。';
            });
        },
      },
    });
  
    searchApp.mount('#search-app');
  });
  