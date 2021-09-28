<template>
  <div class="media">
    <figure class="media-left">
      <p><img :src="book['mediumImageUrl']" :alt="book['title']" /></p>
    </figure>
    <div class="media-content">
      <div class="content">
        <p>
          <a id="book-title" :href="book['affiliateUrl']">{{
            book['title']
          }}</a>
        </p>
        <p class="is-size-7">
          著者：{{ book['author'] }}<br />
          発売：{{ book['salesDate'] }}<br />
          定価：{{ formatPrice(book['itemPrice']) }}
        </p>
      </div>
      <nav class="level">
        <div class="level-right">
          <div class="level-item">
            <button
              v-show="registeredListDetail"
              class="button is-light"
              disabled
            >
              リスト登録済み
            </button>
            <button
              v-show="!registeredListDetail"
              class="button is-success"
              @click="submit"
            >
              セール通知を受け取る
            </button>
          </div>
        </div>
      </nav>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    book: { type: Object, required: true }
  },
  data() {
    return {
      bookId: null,
      listId: null,
      createdBookAndList: false,
      registeredListDetail: false
    }
  },
  watch: {
    createdBookAndList(newValue) {
      if (newValue) {
        this.createListDetail()
      }
    },
    bookId() {
      if (this.listId !== null) {
        this.createdBookAndList = true
      }
    },
    listId() {
      if (this.bookId !== null) {
        this.createdBookAndList = true
      }
    }
  },
  mounted() {
    this.fetchListDetailId()
  },
  methods: {
    submit() {
      this.createOrFindUsersList()
      this.createOrFindBooks()
    },
    createListDetail() {
      fetch('/api/list_details', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.token()
        },
        body: JSON.stringify({
          list_id: this.listId,
          book_id: this.bookId
        }),
        credentials: 'same-origin'
      })
        .then((response) => {
          return response.json()
        })
        .then((json) => {
          if (json.errorMessage) {
            alert(json.errorMessage)
          } else if (json.message) {
            alert(json.message)
            this.registeredListDetail = true
          }
        })
    },
    createOrFindBooks() {
      fetch('/api/books', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.token()
        },
        body: JSON.stringify({
          isbn_13: this.book.isbn,
          price: this.book.itemPrice,
          title: this.book.title,
          author: this.book.author,
          image: this.book.mediumImageUrl,
          url: this.book.affiliateUrl,
          sales_date: this.book.salesDate
        }),
        credentials: 'same-origin'
      })
        .then((response) => {
          return response.json()
        })
        .then((json) => {
          if (json.errorMessage) {
            alert(json.errorMessage)
          } else if (json.bookId) {
            this.bookId = json.bookId
          }
        })
    },
    createOrFindUsersList() {
      if (this.listId === null) {
        fetch('/api/users/lists', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-Token': this.token()
          },
          credentials: 'same-origin'
        })
          .then((response) => {
            return response.json()
          })
          .then((json) => {
            this.listId = json.listId
          })
          .catch((error) => {
            console.warn('Failed to parsing', error)
          })
      }
    },
    fetchListDetailId() {
      fetch(`/api/list_details/id?isbn=${this.book.isbn}`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.token()
        },
        credentials: 'same-origin'
      })
        .then((response) => {
          return response.json()
        })
        .then((json) => {
          if (json.listDetailId) {
            console.log(json)
            this.registeredListDetail = true
          }
        })
    },
    formatPrice(price) {
      return `${price.toLocaleString()}円`
    },
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    }
  }
}
</script>
