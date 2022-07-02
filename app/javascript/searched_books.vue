<template>
  <div>
    <book-item
      v-for="book in books"
      :key="book['Item']['isbn']"
      :book="book['Item']"
    ></book-item>
  </div>
</template>

<script lang="ts">
import bookItem from './searched_book.vue'

export default {
  components: {
    bookItem
  },
  props: {
    books: { type: Object, required: true }
  }
}
</script>
