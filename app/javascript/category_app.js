document.addEventListener('DOMContentLoaded', () => {
    const app = Vue.createApp({
      data() {
        return {
          categories: [], // 카테고리 데이터를 저장
        };
      },
      methods: {
        fetchCategories() {
          axios.get('/categories.json').then((response) => {
            this.categories = response.data;
          });
        },
      },
      mounted() {
        this.fetchCategories(); // 컴포넌트가 로드될 때 카테고리 데이터를 가져옵니다.
      },
    });
    app.mount('#category-app');
});