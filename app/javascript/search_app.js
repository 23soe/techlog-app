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
          if (!this.searchQuery) {
            // 検索ワードがない場合は空配列に設定
            this.filteredPosts = [];
            return;
          }
  
          axios
            .get(`/tags/posts_by_tag?tag=${encodeURIComponent(this.searchQuery)}`)
            .then((response) => {
              this.filteredPosts = response.data; // 検索結果を設定
              this.errorMessage = '';
            })
            .catch((error) => {
                if (error.response && error.response.status === 404) {
                  this.filteredPosts = []; 
                  this.errorMessage = 'データがありません。'; 
                } else {
                  console.error('Error fetching posts by tag:', error);
                  this.errorMessage = 'エラーが発生しました。'; 
                }
            });
        },
      },
    });
  
    searchApp.mount('#search-app');
  });
  