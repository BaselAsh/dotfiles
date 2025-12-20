config.load_autoconfig()
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"
c.editor.command = ["kitty", "nvim", "{file}"]
c.url.searchengines = {
    "DEFAULT": "https://search.brave.com/search?q={}",
}
c.url.start_pages = [
    "https://search.brave.com/",
    "https://gemini.google.com/",
]
