<template>
  <div class="block">
    <book-item
      v-for="book in books"
      :key="book.list_detail_id"
      :book="book.book"
      :list-detail-id="book.list_detail_id"
      @delete-list-detail="getBooks"
    ></book-item>
  </div>
</template>

<script>
import bookItem from './users_lists_book.vue'

export default {
  components: {
    bookItem
  },
  props: {
    listId: { type: String, required: true }
  },
  data() {
    return {
      books: this.getBooks()
    }
  },
  methods: {
    getBooks() {
      fetch(`/api/users/lists/${this.listId}.json`, {
        method: 'GET',
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.token()
        },
        credentials: 'same-origin'
      })
        .then((response) => {
          return response.json()
        })
        .then((json) => {
          const tmpBooks = []
          json.books.forEach((book) => {
            tmpBooks.push(book)
          })
          this.books = tmpBooks
        })
        .catch((error) => {
          console.warn('Failed to parsing', error)
        })
    },
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    }
  }
}
</script>
