<template>
  <div class="media">
    <figure class="media-left">
      <p class="block">
        <img :src="book.image" :alt="book.title" />
      </p>
      <div class="level">
        <div class="level-right">
          <div class="level-item">
            <a
              :href="deleteUrl"
              data-confirm="削除してよろしいですか？"
              data-method="delete"
              class="button is-danger"
              >削除する</a
            >
          </div>
        </div>
      </div>
    </figure>
    <div class="media-content">
      <div class="content">
        <p>
          <a :href="book.url">{{ book.title }}</a>
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

<script>
export default {
  props: {
    book: { type: Object, required: true },
    listDetailId: { type: Number, required: true }
  },
  data() {
    return {
      deleteUrl: `/list_details/${this.listDetailId}`
    }
  },
  methods: {
    formatPrice(price) {
      return `${price.toLocaleString()}円`
    }
  }
}
</script>
