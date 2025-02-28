import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['query']

  perform() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      const query = this.queryTarget.value.trim()
      const resultsContainer = document.getElementById('companies-list')

      if (query.length < 2) {
        resultsContainer.innerHTML = ''
        return
      }

      fetch(`companies/search_results?query=${encodeURIComponent(query)}`, { headers: { 'Accept': 'text/html' } })
        .then(response => response.text())
        .then(html => {
          resultsContainer.innerHTML = html
        })
    }, 300)
  }
}