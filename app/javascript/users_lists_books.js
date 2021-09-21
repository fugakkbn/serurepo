import { createApp } from 'vue'
import Books from './users_lists_books'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-users-lists-books'
  const list = document.querySelector(selector)

  if(list){
    const listId = list.getAttribute('data-list-id')
    createApp(Books, { listId: listId }).mount(selector)
  }
})
