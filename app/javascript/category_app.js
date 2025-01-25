document.addEventListener('DOMContentLoaded', () => {
    const app = Vue.createApp({
      data() {
        return {
          categories: [], 
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
        this.fetchCategories(); 
      },
    });
    app.mount('#category-app');
});