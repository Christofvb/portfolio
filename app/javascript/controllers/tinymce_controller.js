import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.initAll()

    document.addEventListener("turbo:load", () => {
      this.initAll()
    })
  }

  initAll() {
    const textareas = this.element.querySelectorAll("textarea.editor")
    textareas.forEach(textarea => this.initEditor(textarea))
  }

  initEditor(textarea) {
  if (!textarea) return
  if (!textarea.id) textarea.id = "editor_" + new Date().getTime()

  const existing = tinymce.get(textarea.id)
  if (existing) {
    tinymce.remove(existing)
  }

  tinymce.init({
    target: textarea,
    plugins: 'link lists code',
    toolbar: 'undo redo | styleselect | bold italic underline | forecolor backcolor | alignleft aligncenter alignright | bullist numlist | link | code',
    menubar: false,
    height: 300,
    content_style: `
      body { font-family: sans-serif; color: #1f2937; background-color: #f9fafb; }
    `
  })
}

  disconnect() {
    this.element.querySelectorAll("textarea.editor").forEach(textarea => {
      if (tinymce.get(textarea.id)) {
        tinymce.remove(textarea)
      }
    })
  }
}
