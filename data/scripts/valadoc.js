// Some configuration that shouldn't be modified at runtime.
const config = {
  searchDelay: 200, // time (in milliseconds) after which a new search request is triggered
  appName: 'Valadoc'
}

const curpkg = window.location.pathname.split('/')[1]

// cache of the content of tooltips stored by their url
const tooltipCache = {}

// This object will contain the html elements of the interface
const html = {
  tooltipEl: initTooltip(),
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
function initTooltip() {
  const tip = document.createElement('div')
  tip.reset = () => {
    tip.innerHTML = null
    tip.style.top = '-200px'
  }

  tip.show = (content, target) => {
    tip.innerHTML = content

    const targetRect = target.getBoundingClientRect()
    // if tooltip is in a class hierarchy diagram
    if (target.tagName === "AREA") {
      const [areaLeft, areaTop, areaRight, areaBottom] = target.coords.split(',').map(Number) // offset of box in svg graph
      tip.style.top = `${targetRect.top + areaTop + pageYOffset}px`
      tip.style.left = `${targetRect.left + areaRight + pageXOffset + 5}px`
      return
    }

    tip.style.left = `${targetRect.x + pageXOffset}px`
    // this needs to be after tip.style.left=... to compute the correct new height
    const tipRect = tip.getBoundingClientRect()
    const tipOffset = 5 + tipRect.height
    tip.style.top = `${targetRect.top + pageYOffset - tipOffset}px`
  }

  tip.className = 'tooltip'
  tip.style.position = 'absolute'
  document.body.appendChild(tip)
  return tip
}


function setupLink (link) {
  if (link.hostname !== location.hostname
    || link.pathname.endsWith('index.htm')
    || link.pathname.endsWith('.tar.bz2')) {
    return
  }

  link.addEventListener('mouseleave', evt => {
    evt.currentTarget.hovered = false
    html.tooltipEl.reset();
  })

  link.addEventListener('mouseenter', evt => {
      // fullname = path without the / at the beginning and the .htm(l)
    const target = evt.currentTarget
    target.hovered = true
    const fullname = link.pathname.substring(1).replace(/\.html?$/, '')
    if (tooltipCache[fullname]) {
      html.tooltipEl.show(tooltipCache[fullname], target)
    } else {
      fetch(`/tooltip.php?fullname=${encodeURIComponent(fullname)}`, {
        method: 'POST'
      }).then(res => res.text()).then(content => { 
        tooltipCache[fullname] = content
        if (target.hovered) {
          html.tooltipEl.show(content, target)
        }
      })
    }
  })

  link.addEventListener('click', evt => {
    html.tooltipEl.reset()
    loadPage(link)(evt)
  })
}

function loadPage (link, popped = false) {
  return evt => {

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
      html.content.innerHTML = `<h1>Sorry, an error occurred</h1><p>${err.message}</p>`
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

  // register some useful shortcuts
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
          loadPage(html.searchFocused.children[0])(evt)
        }
        break
      case 17: // ctrl
        html.searchField.focus() // we focus the search
        break
    }
  })

  // Conduct a search if the "q" field is present in the URL Parameters
  function parseQueryString (url) {
    let urlParams = {}
    url.replace(
      new RegExp("([^?=&]+)(=([^&]*))?", "g"),
      function($0, $1, $2, $3) {
        urlParams[$1] = $3
      }
    )
    return urlParams
  }
  const urlParams = parseQueryString(location.search)
  if (typeof urlParams.q !== 'undefined' && urlParams.q) {
    html.searchField.value = urlParams.q
    updateSearch()
  }
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
