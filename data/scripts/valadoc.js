// Some configuration that shouldn't be modified at runtime.
const config = {
  searchDelay: 200, // time (in milliseconds) after which a new search request is triggered
  appName: 'Valadoc'
}

const curpkg = window.location.pathname.split('/')[1]

// This object will contain the html elements of the interface
const html = {
  tooltips: []
}

/*
* Makes a request to the server to get search results
*/
function search (query) {
  const postData = new FormData()
  postData.append('query', query)
  postData.append('curpkg', curpkg)

  return fetch('/search.php', {
    method: 'POST',
    body: postData
  }).then(res => {
    if (res.ok) {
      return res.text()
    } else {
      return Promise.resolve(`${res.status}: ${res.statusText}`)
    }
  })
}

/*
* Display a tooltip containing `content` when cursor is over `element`.
*/
function tooltip (element, content, position) {
  const tip = document.createElement('div')
  tip.style.position = 'absolute'
  tip.style.display = 'block'
  tip.innerHTML = content
  tip.className = 'tooltip'
  tip.style.top = `${position.y + 2}px`
  tip.style.left = `${position.x + 2}px`
  document.body.appendChild(tip)

  element.addEventListener('mousemove', evt => {
    tip.style.display = 'block'
    tip.style.top = `${window.scrollY + evt.clientY + 2}px`
    tip.style.left = `${window.scrollX + evt.clientX + 2}px`
  })

  element.addEventListener('mouseleave', () => {
    tip.style.display = 'none'
  })

  return tip
}

function setupLink (link) {
  if (link.hostname !== location.hostname || link.pathname.endsWith('index.htm')) {
    return
  }

  link.addEventListener('mouseenter', evt => {
    if (link.getAttribute('data-init') !== 'yes') {
      // fullname = path without the / at the beggining and the .htm(l)
      const fullname = link.pathname.substring(1).replace(/\.html?$/, '')
      link.setAttribute('data-init', 'yes')
      fetch(`/tooltip.php?fullname=${encodeURIComponent(fullname)}`, {
        method: 'POST'
      }).then(res => res.text()).then(res => {
        for (let tip of html.tooltips) {
          tip.style.display = 'none'
        }

        html.tooltips.push(tooltip(link, res, {
          y: window.scrollY + evt.clientY,
          x: window.scrollX + evt.clientX
        }))
      })
    }
  })

  link.addEventListener('click', loadPage(link))
}

function loadPage (link, popped) {
  return evt => {
    // first, destroy tooltips if any
    for (let tip of html.tooltips) {
      tip.remove()
    }
    html.tooltips = []

    const pageTitle = link.pathname.replace(/(\/index)?\.html?$/, '').substring(1).split('/').reverse().join(' — ')
    const title = `${pageTitle.length ? `${pageTitle} — ` : ''}${config.appName}`
    const pageUrl = `${link.pathname}.content.tpl`
    const sidebarUrl = `${link.pathname}.navi.tpl`

    fetch(pageUrl).then(res => res.text()).then(page => {
      html.content.innerHTML = page
      if (!popped) { // only add this page to the history again if we didn't visited it just before, else we won't be able to go back anymore
        history.pushState(null, title, link.pathname)
      }
      document.title = title

      // Init new tooltips
      document.querySelectorAll('#content a').forEach(setupLink)
      document.querySelectorAll('#content area').forEach(setupLink)
    }).catch(err => {
      html.content.innerHTML = `<h1>Sorry, an error occured</h1><p>${err.message}</p>`
    })

    if (html.searchField.value === '') {
      fetch(sidebarUrl).then(res => res.text()).then(sidebar => {
        html.navigation.innerHTML = sidebar

        // Init new tooltips
        document.querySelectorAll('#navigation-content a').forEach(setupLink)
        document.querySelectorAll('#navigation-content area').forEach(setupLink)
      }).catch(err => {
        console.error('Unable to load sidebar')
        console.error(err)
      })
    }

    evt.preventDefault()
  }
}

window.addEventListener('popstate', loadPage(window.location, true))

// Initialize everything when document is ready
document.addEventListener('DOMContentLoaded', () => {
  // HTML elements
  html.searchBox = document.getElementById('search-box')
  html.searchField = document.getElementById('search-field')
  html.searchResults = document.getElementById('search-results')
  html.searchClear = document.getElementById('search-field-clear')
  html.navigation = document.getElementById('navigation-content')
  html.searchFocused = null // The search result that is currently focused
  html.content = document.getElementById('content')

  // Init search
  html.searchBox.style.display = 'inline-block' // display it (we do it here, so the user without javascript won't see a non-working search box)

  // We run a search when the value changes, after a given delay
  html.searchField.addEventListener('keyup', evt => {
    // only if the pressed key isn't up/down arrow, because we use them to select next/previous search result and not to trigger search
    if (evt.keyCode !== 40 && evt.keyCode !== 38) {
      updateSearch()
    }
  })

  // clear search when clicking on the clear button
  html.searchClear.addEventListener('click', () => {
    html.searchField.value = ''
    html.searchField.focus() // we focus search after clearing
    updateSearch()
  })

  // Init tooltips
  document.querySelectorAll('body > div a').forEach(setupLink)
  document.querySelectorAll('body > div area').forEach(setupLink)

  // register some usefull shortcuts
  document.addEventListener('keyup', evt => {
    switch (evt.keyCode) {
      case 27: // echap
        if (html.searchField === document.activeElement) {
          html.searchField.value = ''
          updateSearch()
        }
        break
      case 38: // up arrrow
        // if we are focusing a search result, but not the first...
        if (html.searchFocused && html.searchFocused.previousElementSibling != null) {
          html.searchFocused.className = html.searchFocused.className.replace(' search-selected', '')
          html.searchFocused = html.searchFocused.previousElementSibling
          html.searchFocused.className = html.searchFocused.className + ' search-selected'
        }
        break
      case 40: // down arrow
        // if we are focusing a search result, but not the last...
        if (html.searchFocused && html.searchFocused.nextElementSibling != null) {
          html.searchFocused.className = html.searchFocused.className.replace(' search-selected', '')
          html.searchFocused = html.searchFocused.nextElementSibling
          html.searchFocused.className = html.searchFocused.className + ' search-selected'
        } else if (document.activeElement === html.searchField) {
          // we focus the first element if we were in the search field
          if (html.searchFocused != null) {
            html.searchFocused.className = html.searchFocused.className.replace(' search-selected', '')
          }
          html.searchFocused = html.searchResults.children[0]
          html.searchFocused.className = html.searchFocused.className + ' search-selected'
        }
        break
      case 13: // enter
        if (html.searchFocused) { // if we have a search item selected, we load its page
          loadPage(html.searchFocused.children[0])
        }
        break
      case 17: // ctrl
        html.searchField.focus() // we focus the search
        break
    }
  })
})

let searchDelay
function updateSearch () {
  if (html.searchField == null || html.searchResults == null) {
    return // Document isn't ready yet
  }

  if (searchDelay) {
    clearTimeout(searchDelay) // reset the delay
  }

  if (html.searchField.value != null && html.searchField.value !== '') {
    // if search isn't empty, we display results after `config.searchDelay` milliseconds
    searchDelay = setTimeout(() => {
      search(html.searchField.value).then(res => {
        html.searchResults.innerHTML = res
      })
      html.navigation.style.display = 'none'
    }, config.searchDelay)
  } else {
    // if the search field is empty, we display the symbols list again
    html.searchResults.innerHTML = ''
    html.navigation.style.display = 'block'
    html.searchFocused = null
  }
}
