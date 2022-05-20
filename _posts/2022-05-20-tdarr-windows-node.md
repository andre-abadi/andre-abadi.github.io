---
layout: default
title: Tdarr Windows Node
date: 2022-05-20 19:42:00 +0800
---

# Purpose
- Add a Windows node to the Tdarr setup

# References
- [Tdadd: Downloads](https://docs.tdarr.io/docs/installation/windows-linux-macos/)
- [Tdarr Docs: Windows, Linux and macOS](https://docs.tdarr.io/docs/installation/windows-linux-macos)
- [Reddit: Windows Node to Windows Server Path error](https://www.reddit.com/r/Tdarr/comments/mqxh0k/comment/gukznxs/?utm_source=share&utm_medium=web2x&context=3)
- [Reddit: Tdarr with network file location](https://www.reddit.com/r/Tdarr/comments/tkdj0s/tdarr_with_network_file_location/)

# Actions
- Download `Tdarr_Updater win32_x64`
- Unzip to `C:\Tdarr\`
- Run `Tdarr_Updater.exe`
- Edit `C:\Tdarr\configs\Tdarr_Node_Config.json`
- Overcautious of warning "If using backslashes in paths, make sure to use double backlashes \\ or the JSON will be corrupt" on the [Tdarr docs](https://docs.tdarr.io/docs/installation/windows-linux-macos/) I used four backslashes as the Windows file paths i.e. `\\\\[IP]\\series`
- Errors
- Found this [Reddit thread](https://www.reddit.com/r/Tdarr/comments/mqxh0k/windows_node_to_windows_server_path_error/) showing that forward slashes could be used
- Developed correct code, see code section below

# Reflections
- Hard part was exposing the cache between the server SSD and the Windows node

# Code
```
{
  "nodeID": "[PC]",
  "serverIP": "[SERVER IP]",
  "serverPort": "8266",
  "handbrakePath": "",
  "ffmpegPath": "",
  "mkvpropeditPath": "",
  "pathTranslators": [
    {
      "server": "/media/series",
      "node": "//[NAS]/series"
    },
    {
      "server": "/media/movies",
      "node": "//[NAS]/movies"
    },
    {
      "server": "/temp",
      "node": "//[SERVER]/tdarr"
    }
  ],
  "platform_arch": "win32_x64_docker_false",
  "logLevel": "INFO"
}
```