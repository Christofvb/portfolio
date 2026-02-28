import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

// Utilise l'instance existante de Stimulus
const application = window.StimulusApp
if (!application) throw new Error("StimulusApp non initialisé !")

console.log("controllers/index.js chargé")

eagerLoadControllersFrom("controllers", application)

console.log("Controllers détectés :", application.controllers.map(c => c.identifier))
