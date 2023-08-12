export const Hooks = {
  PageNav: {
    mounted() {
      pp("PageNav.mounted")
      const main_el = window
      const content_el = this.el

      main_el.addEventListener("click", (ev) => {
        if (ev.isTrusted) {
          const pos = content_el.getBoundingClientRect()
          pp("PageNav.click", ev.x, pos)
          
          if (ev.x < pos.left) {
            document.querySelector(".page-prev").click()
          } else if (ev.x > pos.right) {
            document.querySelector(".page-next").click()
          }
        }
      })
    },

    updated() {
      pp("PageNav.updated")
    }
  }
}
