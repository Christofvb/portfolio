import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["projects", "template"]

  connect() {
    this.projectsTarget.querySelectorAll("textarea.editor").forEach((textarea) => this.initTinyMCE(textarea))
  }

  add(event) {
    event.preventDefault()

    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.projectsTarget.insertAdjacentHTML("beforeend", content)

    const newProject = this.projectsTarget.lastElementChild
    newProject.querySelectorAll("textarea.editor").forEach((textarea) => this.initTinyMCE(textarea))
  }

  remove(event) {
    event.preventDefault()
    const item = event.target.closest(".default-form-project")
    if (!item) return
    const destroyInput = item.querySelector('input[type="checkbox"][name*="_destroy"]')
    if (destroyInput) {
      destroyInput.checked = true
      item.style.display = "none"
    } else {
      item.remove()
    }
  }

  initTinyMCE(textarea) {
    if (!textarea) return
    if (!textarea.id) textarea.id = "editor_" + new Date().getTime()
    if (typeof tinymce === "undefined") return
    if (tinymce.get(textarea.id)) return

    requestAnimationFrame(() => {
      tinymce.init({
        target: textarea,
        plugins: 'link lists code',
        toolbar: 'undo redo | styleselect | bold italic underline | forecolor backcolor | alignleft aligncenter alignright | bullist numlist | link | code',
        menubar: false,
        height: 300,
        content_style: `
          body { font-family: sans-serif; color: #1f2937; background-color: #f9fafb; }
          h1,h2,h3,h4,h5,h6 { color: #111827; }
          p { color: #374151; }
        `
      })
    })
  }
}
