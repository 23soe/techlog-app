<template>
  <div>
    <h1 class="text-xl font-bold text-gray-700">学習ログ一覧</h1>
    <div class="flex flex-wrap gap-2 mt-2">
      <button
        v-for="category in categories"
        :key="category.id"
        @click="selectCategory(category.id)"
        class="text-blue-500 hover:underline px-4 py-2 bg-gray-100 rounded shadow-sm"
      >
        {{ category.name }}
      </button>
    </div>

    <div v-if="selectedCategory">
      <h2 class="text-lg font-bold mt-6">{{ selectedCategory.name }} の投稿一覧</h2>
      <div v-for="post in posts" :key="post.id" class="bg-white p-4 rounded shadow mt-4">
        <h3 class="text-gray-800 font-bold">
          {{ post.title }}
        </h3>
        <p class="text-gray-600">{{ post.content }}</p>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      categories: [],
      selectedCategory: null,
      posts: [],
    };
  },
  methods: {
    async fetchCategories() {
      try {
        const response = await axios.get("http://127.0.0.1:3000/api/categories");
        this.categories = response.data;
      } catch (error) {
        console.error("Failed to fetch categories:", error);
      }
    },
    async selectCategory(categoryId) {
      try {
        const response = await axios.get(
          `http://127.0.0.1:3000/api/categories/${categoryId}`
        );
        this.selectedCategory = response.data.category;
        this.posts = response.data.posts;
      } catch (error) {
        console.error("Failed to fetch category data:", error);
      }
    },
  },
  mounted() {
    this.fetchCategories();
  },
};
</script>

<style>
/* Add any custom styles here */
</style>
