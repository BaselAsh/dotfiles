import sys
import yt_dlp


class YTDownloader:
    def __init__(self):
        self.ydl_opts_base = {"quiet": True, "no_warnings": True}

    def format_size(self, bytes):
        if bytes is None:
            return "N/A"
        for unit in ["B", "KB", "MB", "GB"]:
            if bytes < 1024:
                return f"{bytes:.1f}{unit}"
            bytes /= 1024
        return f"{bytes:.1f}TB"

    def progress_hook(self, d):
        if d["status"] == "downloading":
            p = d.get("_percent_str", "0%")
            speed = d.get("_speed_str", "N/A")
            print(f"\r[Downloading] {p} | Speed: {speed}  ", end="")
        elif d["status"] == "finished":
            print("\nDownload complete! Merging streams...")

    def list_formats(self, url):
        with yt_dlp.YoutubeDL(self.ydl_opts_base) as ydl:
            info = ydl.extract_info(url, download=False)
            formats = info.get("formats", [])

        print(f"\nTitle: {info.get('title')}")
        print(f"{'ID':<7} {'EXT':<7} {'RES':<10} {'SIZE':<10} {'CODEC':<12}")
        print("-" * 60)

        ids = []
        for f in formats:
            if f.get("vcodec") != "none" and f.get("height"):
                f_id = f.get("format_id")
                size = self.format_size(f.get("filesize") or f.get("filesize_approx"))
                vcodec = f.get("vcodec", "unknown").split(".")[0]

                # Highlight the best codec for your hardware
                star = "*" if vcodec == "avc1" else " "

                print(
                    f"{f_id:<7} {f['ext']:<7} {f['height']}p{star:<7} {size:<10} {vcodec:<12}"
                )
                ids.append(f_id)
        return ids

    def download(self, url, format_id):
        opts = {
            "format": f"{format_id}+bestaudio/best",
            "outtmpl": "~/Storage/Videos/%(title)s.%(ext)s",
            "progress_hooks": [self.progress_hook],
            "quiet": True,
        }
        with yt_dlp.YoutubeDL(opts) as ydl:
            ydl.download([url])


if __name__ == "__main__":
    app = YTDownloader()
    if len(sys.argv) > 2:
        url = sys.argv[1]
        choice = sys.argv[2]
        app.download(url, choice)
        # Keep the window open so you can see the "Finished" message
        input("\nPress Enter to close...")
    else:
        # Fallback for manual running
        link = input("Enter YouTube URL: ")
        valid_ids = app.list_formats(link)
        choice = input("\nEnter ID: ")
        app.download(link, choice)
