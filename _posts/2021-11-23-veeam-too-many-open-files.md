---
layout: default
title: Veeam - Too Many Open Files
date: 2021-11-23 12:00:00 +0800
tags:
- home automation
---

# Purpose
- Overcome error when patching Veeam ISO:
  > ISO: FATAL ERROR:write_file: failed to create file /tmp/veeam/livecd-..., because Too many open files

# References
- [Veeam Knowledge Base KB4121](https://www.veeam.com/kb4121)


# Actions
- Found [Veeam Knowledge Base KB4121](https://www.veeam.com/kb4121)
- `sudo systemctl edit veeamservice.service` (opened up in Nano)
- Pasted in:
    ```bash
    [Service]
    LimitNOFILE=524288
    LimitNOFILESoft=524288
    ```
- `CTRL+O` to write buffer to ... wherever
- `CTRL+X` exit Nano
- `sudo systemctl daemon-reload`
- `sudo systemctl restart veeamservice.service`
- `sudo veeam`
- Tried again, it worked.

# Observations
- Nil
