<template>
  <div class="media">
    <figure class="media-left">
      <p class="block">
        <img :src="book.image" :alt="book.title" />
      </p>
      <div class="level">
        <div class="level-right">
          <div class="level-item">
            <a class="button is-danger" @click="deleteListDetail">削除する</a>
          </div>
        </div>
      </div>
    </figure>
    <div class="media-content">
      <div class="content">
        <p>
          <a :href="book.url" target="_blank" rel="noopener noreferrer">{{
            book.title
          }}</a>
        </p>
        <p class="is-size-7">
          著者:{{ book.author }}<br />
          発売:{{ book.sales_date }}<br />
          定価:{{ formatPrice(book.price) }}<br />
        </p>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
export default {
  props: {
    book: { type: Object, required: true },
    listDetailId: { type: Number, required: true }
  },
  data() {
    return {
      deleteUrl: `/api/list_details/${this.listDetailId}`
    }
  },
  methods: {
    deleteListDetail() {
      if (confirm('削除してよろしいですか？')) {
        fetch(this.deleteUrl, {
          method: 'DELETE',
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
            if (json.errorMessage) {
              alert(json.errorMessage)
            } else if (json.successMessage) {
              alert(json.successMessage)
              this.$emit('delete-list-detail')
            }
          })
      }
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
