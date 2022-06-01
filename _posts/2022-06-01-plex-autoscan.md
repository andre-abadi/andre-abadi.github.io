---
layout: default
title: Plex Autoscan
date: 2022-06-01 19:41:00 +0800
tags:
---

# Purpose
- Integrate Tdarr with some sort of Plex auto scanning to prevent renamed media from erroring in Plex until Plex does a whole of library refresh once a day or so

# References
- [Tdarr Community Plugins](https://github.com/HaveAGitGat/Tdarr_Plugins/tree/master/Community)
- [Github / l3uddz / autoscan](https://github.com/l3uddz/plex_autoscan)
- [Github / Cloudbox / autoscan](https://github.com/cloudbox/autoscan)
- [hotio dockerised version of Cloudbox autoscan](https://hotio.dev/containers/autoscan/)

# Actions
- Search Tdarr for plugins with keyword *Plex* giving candidates:
  - `Tdarr_Plugin_MC93_MigzPlex_Autoscan`
  - `Tdarr_Plugin_MP01_MichPasCleanSubsAndAudioCodecs`
  - `Tdarr_Plugin_TD01_TOAD_Autoscan`
  - `Tdarr_Plugin_goof1_URL_Plex_Refresh`
- `[https://github.com/l3uddz/plex_autoscan` seems to have been superceded by `https://github.com/cloudbox/autoscan`
- `https://hotio.dev/containers/autoscan/` seems to be a dockerised version of the newer `https://github.com/cloudbox/autoscan`
- Attempted to get `https://hotio.dev/containers/autoscan/` up and running
- See `docker-compose.yml` at the end of this post
- No instructions on how to get *Plex Token* at [https://hotio.dev/containers/autoscan/](https://hotio.dev/containers/autoscan/)
- `https://github.com/l3uddz/plex_autoscan` instructs to find *Plex Token* by going to [this page](https://support.plex.tv/articles/204059436-finding-an-authentication-token-x-plex-token/)
- Opened an arbitrary library item in Plex web
  - Get Info
  - View XML
- Check URL of XML opened in Chrome new tab
- Found X-Plex-Token at end of said URL
- Created `/[mapped docker path]/autoscan/plex.token` and placed token string inside
- Did not like running as root
- Commented out `PUID`, `PGID`, `PLEX_LOGIN`, `PLEX_PASSWORD` env variables
```
Jun  1 19:55:28 INF Initialised processor anchors=[] min_age=10m0s
Jun  1 19:55:28 WRN Webhooks running without authentication
Jun  1 19:55:28 INF Initialised triggers bernard=0 inotify=0 lidarr=0 manual=1 radarr=0 sonarr=1
Jun  1 19:55:28 INF Initialised targets autoscan=0 emby=0 jellyfin=0 plex=0
Jun  1 19:55:28 INF Initialised version=" (@)"
Jun  1 19:55:28 INF Processor started
Jun  1 19:55:28 WRN No targets initialised, processor stopped, triggers will continue...
Jun  1 19:55:28 INF Starting server on port 3030
```
- Runs but doesn't seem to have found Plex
- Refer back to original [l3uddz/plex_autoscan](https://github.com/l3uddz/plex_autoscan) docs
- Tried using Plex credentials
```
Something went wrong trying to get a token!
```
- Re-added in the `plex.token` file
- Restarted `hotio/autoscan`
```
Jun  1 20:02:30 INF Initialised processor anchors=[] min_age=10m0s
Jun  1 20:02:30 WRN Webhooks running without authentication
Jun  1 20:02:30 INF Initialised triggers bernard=0 inotify=0 lidarr=0 manual=1 radarr=0 sonarr=1
Jun  1 20:02:30 INF Initialised targets autoscan=0 emby=0 jellyfin=0 plex=0
Jun  1 20:02:30 INF Initialised version=" (@)"
Jun  1 20:02:30 INF Processor started
Jun  1 20:02:30 INF Starting server on port 3030
Jun  1 20:02:30 WRN No targets initialised, processor stopped, triggers will continue...
```
- Added `Tdarr_Plugin_TD01_TOAD_Autoscan` Plugin to Tdarr (last in stack)
- Started a transcode
- Upon completion of transcode stack, the following log appeared in the Docker container:
```
Jun  1 20:05:22 INF Scan moved to processor id=cablc0nf2ncti8pqmifg method=POST path="/media/series/MasterChef Australia/Season 14" url=/triggers/manual?dir=%2Fmedia%2Fseries%2FXXXXXXXXXXX%2FSeason%2014%2F
```
- Tried playing file in Plex
- File worked, but no change in file extension, so unknown if it worked
- Checked Tdarr worker logs and found the following
```
2022-06-01T20:05:24.206Z Post-processing - Trigger Plex_Autoscan.
2022-06-01T20:05:24.208Z Y9MY6rjGt:Removing original item from database
2022-06-01T20:05:24.268Z Y9MY6rjGt:Adding new file to database
2022-06-01T20:05:25.306Z Y9MY6rjGt:Updating size stats
```
- Appears to have done something?
- Need a dirtier file to see if it's working
- Logs suggest file size was updated in Plex DB
- Check file size in Plex Media Info
- Size shows `372.89MB`
- This matches Tdarr, which has *Old Size* `326.6 MB` and New Size `372.9 MB` suggesting the Plex database was successfully updated!
- Remove `PLEX_LOGIN` and `PLEX_PASSWORD` from docker-compose.yml since it should be redundant with the presence of `plex.token`
- Queued another file through Tdarr to see if this still worked
- Plex DB was correctly updated with file size once `autoscan` logs showed the task was completed
- Also to find a file with wrong extension to download in Sonarr to test whether this is correctly updated in Plex
- 

# Reflections


# Code

## Notes

- For below to work requires presence of `plex.token` at mapped directory of `/config/plex.token`
- `plex.token` must contain just the string of alphanumerics after tht `X-Plex-Token=` part of the File Info XML on any Plex library item (see Plex help article on [Finding an authentication token / X-Plex-Token](Finding an authentication token / X-Plex-Token))

## Docker Compose
```
version: '3.4'

services:
  autoscan:
    container_name: autoscan
    hostname: autoscan
    image: cr.hotio.dev/hotio/autoscan
    restart: unless-stopped
    environment:
      - TZ=Australia/Perth
    ports:
      - "3030:3030"
    network_mode: "bridge"
    healthcheck:
      test: curl --silent --fail --output /dev/null --insecure http://localhost:3030 || exit 1
      interval: 10s
      timeout: 5s
      retries: 3
      start_period: 120s
    volumes:
      - "~/.docker/autoscan/config:/config"
      - "/etc/localtime:/etc/localtime:ro"
```

## Tdarr Plugin Stack
```
Community,Tdarr_Plugin_lmg1_Reorder_Streams,,Community,Tdarr_Plugin_MC93_MigzImageRemoval,,Community,Tdarr_Plugin_x7ac_Remove_Closed_Captions,,Local,fo_XOQaFu,,Local,i-9iCPDL3,,Local,j6yeumXkA,,Community,Tdarr_Plugin_MC93_Migz5ConvertAudio,,Community,Tdarr_Plugin_c0r1_SetDefaultAudioStream,,Community,Tdarr_Plugin_MC93_Migz6OrderStreams,,Community,Tdarr_Plugin_TD01_TOAD_Autoscan,,
```