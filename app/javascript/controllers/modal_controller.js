import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = []

  connect() {
    console.log("✅ ModalController connecté !")
    document.addEventListener("keydown", this.escapeClose)
  }

  open(event) {
    const modalId = event.currentTarget.dataset.modalTarget
    const modal = document.getElementById(modalId)
    if (modal) {
      modal.classList.remove("hidden")
      console.log("Ouverture de la modale :", modalId)
    }
  }

  close(event) {
    // Cherche le parent .modal-overlay même plusieurs niveaux au-dessus
    let modal = event.currentTarget.closest(".modal-overlay")
    if (!modal) {
      let el = event.currentTarget
      while (el && !el.classList.contains("modal-overlay")) {
        el = el.parentElement
      }
      modal = el
    }

    if (modal) {
      modal.classList.add("hidden")
      console.log("Fermeture de la modale")
    } else {
      console.log("Aucun overlay trouvé pour fermer !", event.currentTarget)
    }
  }

  overlayClick(event) {
    if (event.target === event.currentTarget) {
      event.currentTarget.classList.add("hidden")
      console.log("Fermeture de la modale via overlay")
    }
  }

  escapeClose = (event) => {
    if (event.key === "Escape") {
      document.querySelectorAll(".modal-overlay").forEach(modal => {
        modal.classList.add("hidden")
      })
      console.log("Fermeture de toutes les modales via Escape")
    }
  }
}
