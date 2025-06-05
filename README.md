# gaud

`gaud` is a lightweight command line tool for quickly downloading the audio from
YouTube videos and saving it as an `.m4a` file.

## Features

- Downloads audio using `yt-dlp`
- Converts to `.m4a` with `ffmpeg`
- Optionally cleans the output file name

## Installation

Run the provided installer which copies the script to `~/.local/bin` and tries
to install any missing dependencies using your system package manager
(Homebrew on macOS, `apt`, `dnf`, `pacman` etc. on Linux):

```bash
./install.sh
```

After installation make sure `~/.local/bin` is in your `PATH`.

## Usage

```bash
gaud [OPTIONS] <YouTube URL>
```

Options:

```
  --keep           Keep the intermediate .webm file
  --clean-name     Rename output file using artist and title
  --version        Show the gaud version and exit
  -h, --help       Show this help message and exit
```

Example:

```bash
gaud --clean-name https://www.youtube.com/watch?v=dQw4w9WgXcQ
```
