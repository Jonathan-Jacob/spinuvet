import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ["allIngredientsContainer", "selectedContainer"];
  }

  connect() {
    const turboFrame = document.getElementById('product-ingredients');
    turboFrame.addEventListener('turbo:frame-load', () => {
      const draggables = document.querySelectorAll('[draggable="true"]');

      draggables.forEach(draggable => {
        draggable.addEventListener('dragstart', () => {
          draggable.classList.add('cursor-grabbing', 'opacity-50');
          draggable.classList.remove('cursor-grab');
        })

        draggable.addEventListener('dragend', () => {
          draggable.classList.add('cursor-grab');
          draggable.classList.remove('cursor-grabbing', 'opacity-50');
        })
      })

      this.selectedContainerTarget.addEventListener('dragover', event => {
        event.preventDefault();
        const afterElement = getDragAfterElement(container, event.clientY);
        const draggable = document.querySelector('.dragging');
        if (afterElement == null) {
          container.appendChild(draggable);
        } else {
          container.insertBefore(draggable, afterElement);
        }
      })

      const getDragAfterElement = (container, y) => {
        const draggableElements = Array.from(container.querySelectorAll('.draggable:not(.dragging)'));
        return draggableElements.reduce((closest, child) => {
          const box = child.getBoundingClientRect();
          const offset = y - box.top - box.height / 2;
          if (offset < 0 && offset > closest.offset) {
            return { offset: offset, element: child };
          } else {
            return closest;
          }
        }, { offset: Number.NEGATIVE_INFINITY }).element;
      }
    });
  }

  add(event) {
    const tempNewNode = document.createElement('div');
    tempNewNode.innerHTML = `<div class="flex justify-between items-center sm:ml-2 p-2 my-2 bg-white rounded border border-gray-300 shadow-sn">
      <div class="flex items-center gap-2 overflow-hidden">
        <button name="button" type="button" class="cursor-grab">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" class="w-5 h-5">
            <path fill-rule="evenodd" d="M10 3a.75.75 0 01.55.24l3.25 3.5a.75.75 0 11-1.1 1.02L10 4.852 7.3 7.76a.75.75 0 01-1.1-1.02l3.25-3.5A.75.75 0 0110 3zm-3.76 9.2a.75.75 0 011.06.04l2.7 2.908 2.7-2.908a.75.75 0 111.1 1.02l-3.25 3.5a.75.75 0 01-1.1 0l-3.25-3.5a.75.75 0 01.04-1.06z" clip-rule="evenodd"></path>
          </svg>
        </button>
        <div data-ingredient-id="${event.currentTarget.dataset.ingredientId}">${event.currentTarget.dataset.ingredientName}</div>
      </div>
      <div class="flex items-center gap-1">
        <a target="_blank" href="/admin/ingredients/${event.currentTarget.dataset.ingredientId}">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" class="w-5 h-5">
            <path d="M8 10a1.5 1.5 0 113 0 1.5 1.5 0 01-3 0z"></path>
            <path fill-rule="evenodd" d="M4.5 2A1.5 1.5 0 003 3.5v13A1.5 1.5 0 004.5 18h11a1.5 1.5 0 001.5-1.5V7.621a1.5 1.5 0 00-.44-1.06l-4.12-4.122A1.5 1.5 0 0011.378 2H4.5zm5 5a3 3 0 101.524 5.585l1.196 1.195a.75.75 0 101.06-1.06l-1.195-1.196A3 3 0 009.5 7z" clip-rule="evenodd"></path>
          </svg>
        </a>
        <button name="button" type="button" data-action="product-ingredients#remove" data-ingredient-id="${event.currentTarget.dataset.ingredientId}" data-ingredient-name="${event.currentTarget.dataset.ingredientName}">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" class="w-5 h-5">
            <path fill-rule="evenodd" d="M4.28 3.22a.75.75 0 00-1.06 1.06L8.94 10l-5.72 5.72a.75.75 0 101.06 1.06L10 11.06l5.72 5.72a.75.75 0 101.06-1.06L11.06 10l5.72-5.72a.75.75 0 00-1.06-1.06L10 8.94 4.28 3.22z" clip-rule="evenodd"></path>
          </svg>
        </button>
      </div>
    </div>`;
    this.selectedContainerTarget.appendChild(tempNewNode.firstChild);
    const tempOldNode = document.createElement('div');
    tempOldNode.innerHTML = `<div class="flex justify-between items-center sm:mr-2 p-2 pl-4 my-2 bg-white rounded border border-gray-300 shadow-sm">
      <div class="text-gray-400 overflow-hidden">${event.currentTarget.dataset.ingredientName}</div>
      <div class="flex items-center gap-1 hidden">
        <a target="_blank" href="/admin/ingredients/${event.currentTarget.dataset.ingredientId}">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" class="w-5 h-5">
            <path d="M8 10a1.5 1.5 0 113 0 1.5 1.5 0 01-3 0z"></path>
            <path fill-rule="evenodd" d="M4.5 2A1.5 1.5 0 003 3.5v13A1.5 1.5 0 004.5 18h11a1.5 1.5 0 001.5-1.5V7.621a1.5 1.5 0 00-.44-1.06l-4.12-4.122A1.5 1.5 0 0011.378 2H4.5zm5 5a3 3 0 101.524 5.585l1.196 1.195a.75.75 0 101.06-1.06l-1.195-1.196A3 3 0 009.5 7z" clip-rule="evenodd"></path>
          </svg>
          </a>
        <button name="button" type="button" data-action="product-ingredients#add" data-ingredient-id="${event.currentTarget.dataset.ingredientId}" data-ingredient-name="${event.currentTarget.dataset.ingredientName}">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" class="w-5 h-5">
            <path d="M10.75 4.75a.75.75 0 00-1.5 0v4.5h-4.5a.75.75 0 000 1.5h4.5v4.5a.75.75 0 001.5 0v-4.5h4.5a.75.75 0 000-1.5h-4.5v-4.5z"></path>
          </svg>
        </button>
      </div>
    </div>`;
    const ingredientNode = event.currentTarget.parentNode.parentNode;
    ingredientNode.parentNode.replaceChild(tempOldNode.firstChild, ingredientNode);
  }

  remove(event) {
    event.currentTarget.parentNode.parentNode.remove();
    const tempNode = document.createElement('div');
    tempNode.innerHTML = `<div class="flex justify-between items-center sm:mr-2 p-2 pl-4 my-2 bg-white rounded border border-gray-300 shadow-sm">
      <div class=" overflow-hidden">${event.currentTarget.dataset.ingredientName}</div>
      <div class="flex items-center gap-1 ">
        <a target="_blank" href="/admin/ingredients/${event.currentTarget.dataset.ingredientId}">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" class="w-5 h-5">
            <path d="M8 10a1.5 1.5 0 113 0 1.5 1.5 0 01-3 0z"></path>
            <path fill-rule="evenodd" d="M4.5 2A1.5 1.5 0 003 3.5v13A1.5 1.5 0 004.5 18h11a1.5 1.5 0 001.5-1.5V7.621a1.5 1.5 0 00-.44-1.06l-4.12-4.122A1.5 1.5 0 0011.378 2H4.5zm5 5a3 3 0 101.524 5.585l1.196 1.195a.75.75 0 101.06-1.06l-1.195-1.196A3 3 0 009.5 7z" clip-rule="evenodd"></path>
          </svg>
          </a>
        <button name="button" type="button" data-action="product-ingredients#add" data-ingredient-id="${event.currentTarget.dataset.ingredientId}" data-ingredient-name="${event.currentTarget.dataset.ingredientName}">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" class="w-5 h-5">
            <path d="M10.75 4.75a.75.75 0 00-1.5 0v4.5h-4.5a.75.75 0 000 1.5h4.5v4.5a.75.75 0 001.5 0v-4.5h4.5a.75.75 0 000-1.5h-4.5v-4.5z"></path>
          </svg>
        </button>
      </div>
    </div>`
    const ingredientNode = this.allIngredientsContainerTarget.querySelector(`[data-ingredient-id='${event.currentTarget.dataset.ingredientId}']`).parentNode.parentNode;
    ingredientNode.parentNode.replaceChild(tempNode.firstChild, ingredientNode);
  }

}
