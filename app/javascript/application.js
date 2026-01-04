// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('click', (event) => {
	const el = event.target.closest && event.target.closest('a[data-method]')
	if (!el) return
	const method = (el.getAttribute('data-method') || '').toUpperCase()
	if (!['DELETE', 'POST', 'PUT', 'PATCH'].includes(method)) return

	event.preventDefault()

	const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content

	fetch(el.href, {
		method: method,
		headers: {
			'X-CSRF-Token': csrfToken,
			'Accept': 'text/vnd.turbo-stream.html, text/html, application/xhtml+xml'
		},
		credentials: 'same-origin'
	}).then(response => {
		if (response.redirected) {
			window.location = response.url
		} else if (response.ok) {
			if (window.Turbo && response.headers.get('content-type')?.includes('text/vnd.turbo-stream.html')) {
				response.text().then(html => Turbo.renderStreamMessage(html))
			} else {
				window.location.reload()
			}
		} else {
			console.error('Request failed', response.status)
		}
	})
})
