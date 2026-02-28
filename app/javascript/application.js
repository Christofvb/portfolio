import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import TinyMCEController from "controllers/tinymce_controller"
import ProjectsController from "controllers/projects_controller"
import ModalController from "controllers/modal_controller"
import TypingController from "controllers/typing_controller"

const application = Application.start()
window.Stimulus = application
window.StimulusApp = application

application.register("tinymce", TinyMCEController)
application.register("projects", ProjectsController)
application.register("modal", ModalController)
application.register("typing", TypingController)
