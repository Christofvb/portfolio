import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.ctx = this.element.getContext("2d")
    this.particles = []
    this.animationId = null

    this.resize()
    this.initParticles()
    this.animate()

    this.resizeHandler = this.resize.bind(this)
    window.addEventListener("resize", this.resizeHandler)
  }

  disconnect() {
    window.removeEventListener("resize", this.resizeHandler)
    cancelAnimationFrame(this.animationId)
  }

  resize() {
    this.element.width  = window.innerWidth
    this.element.height = window.innerHeight
    if (this.particles.length > 0) this.initParticles()
  }

  initParticles() {
    const area  = this.element.width * this.element.height
    const count = Math.min(Math.floor(area / 14000), 90)

    this.particles = Array.from({ length: count }, () => ({
      x:  Math.random() * this.element.width,
      y:  Math.random() * this.element.height,
      vx: (Math.random() - 0.5) * 0.35,
      vy: (Math.random() - 0.5) * 0.35,
      r:  Math.random() * 1.8 + 0.8
    }))
  }

  animate() {
    const canvas = this.element
    const ctx    = this.ctx
    const MAX    = 140

    ctx.clearRect(0, 0, canvas.width, canvas.height)

    for (let i = 0; i < this.particles.length; i++) {
      const p = this.particles[i]

      p.x += p.vx
      p.y += p.vy
      if (p.x < 0 || p.x > canvas.width)  p.vx *= -1
      if (p.y < 0 || p.y > canvas.height) p.vy *= -1

      // Dot
      ctx.beginPath()
      ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2)
      ctx.fillStyle = "rgba(0, 212, 255, 0.75)"
      ctx.fill()

      // Lines to neighbours
      for (let j = i + 1; j < this.particles.length; j++) {
        const q    = this.particles[j]
        const dx   = p.x - q.x
        const dy   = p.y - q.y
        const dist = Math.sqrt(dx * dx + dy * dy)

        if (dist < MAX) {
          ctx.beginPath()
          ctx.moveTo(p.x, p.y)
          ctx.lineTo(q.x, q.y)
          ctx.strokeStyle = `rgba(0, 212, 255, ${(1 - dist / MAX) * 0.2})`
          ctx.lineWidth   = 0.6
          ctx.stroke()
        }
      }
    }

    this.animationId = requestAnimationFrame(this.animate.bind(this))
  }
}
