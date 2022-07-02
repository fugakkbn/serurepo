import { createApp } from 'vue'
import searchedBooks from './searched_books.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-searched-books'
  const booksDom = document.querySelector(selector)

  if (booksDom) {
    let books = booksDom.getAttribute('data-searched-books')
    books = JSON.parse(books)
    createApp(searchedBooks, {
      books: books
    }).mount(selector)
  }
})
