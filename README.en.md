<!-- LANG_START -->
🇷🇺 [Русская версия](README.md)
<!-- LANG_END -->

<div align="center">

<img src="resources/header.svg" alt="Ricoh Aficio SP-111 Driver" width="900"/>

</div>





<!-- STATS_START -->
<!-- auto-updated by GitHub Actions · 2026-07-02 12:02 UTC -->

[![Views local](https://img.shields.io/badge/Views_local-95-ff6900?style=for-the-badge&logo=github)](https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8)
[![Views GitHub](https://img.shields.io/badge/Views_GitHub-5-ff6900?style=for-the-badge&logo=github)](https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8)
[![Unique visitors](https://img.shields.io/badge/Unique-3-blue?style=for-the-badge&logo=github)](https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8)
[![Clones](https://img.shields.io/badge/Clones-519-purple?style=for-the-badge&logo=github)](https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8)
[![Stars](https://img.shields.io/badge/Stars-0-yellow?style=for-the-badge&logo=github)](https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8/stargazers)
[![Forks](https://img.shields.io/badge/Forks-0-green?style=for-the-badge&logo=github)](https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8/network/members)
[![Downloads latest release](https://img.shields.io/badge/Downloads_latest_release-0-brightgreen?style=for-the-badge)](https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8/releases/latest)
[![Downloads total assets](https://img.shields.io/badge/Downloads_total_assets-0-brightgreen?style=for-the-badge)](https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8/releases)

<!-- STATS_END -->









<!-- GRAPH_START -->
<p align="center">
  <img src="./traffic-views.png" width="100%" alt="GitHub Traffic">
</p>
<!-- GRAPH_END -->










<!-- ISSUES_START -->
<!-- auto-updated by GitHub Actions · 2026-07-02 12:02 UTC -->

## Issues

<p>
  <a href="https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8/issues">
    <img alt="Open issues" src="https://img.shields.io/badge/Open_issues-0-blue?style=for-the-badge&logo=github">
  </a>
  <a href="https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8/issues/new/choose">
    <img alt="Create issue" src="https://img.shields.io/badge/Create_issue-new-success?style=for-the-badge&logo=github">
  </a>
</p>

<details open>
<summary><b>Open issues</b></summary>


<p align="center">
  <b>No open issues.</b><br>
  <sub>The service issue <code>views-counter</code> is hidden from the list.</sub>
</p>


</details>

<p>
  <a href="https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8/issues/new/choose">Create new issue</a> ·
  <a href="https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8/issues">All issues</a>
</p>

<!-- ISSUES_END -->




## Driver Ricoh Aficio SP-111

This is a fork of the old `pstoricohddst-gdi` driver for `Ricoh SP 100/111/204 DDST` series printers.

In this fork:

- fixed filter operation on modern `CUPS` and `Ghostscript`;
- unstable asynchronous mode is disabled via `inotifywait`;
- temporary files are created in `/var/spool/cups/tmp`, which works better in `Astra Linux`;
- more convenient debug logging enabled;
- added `install.sh` for installation from the current project folder.

## Composition

- `pstoricohddst-gdi` — CUPS filter;
- `RICOH_Aficio_SP_100.ppd` — PPD for SP 100;
- `RICOH_Aficio_SP_111.ppd` — PPD for SP 111;
- `RICOH_Aficio_SP_204.ppd` — PPD for SP 204;
- `check-requirements` — dependency checking;
- `install.sh` — setting the filter and PPD from a relative path.

## Dependencies

Check for dependencies:

```bash
./check-requirements
```

If something is missing, install the packages:

```bash
sudo apt update
sudo apt install cups ghostscript imagemagick jbigkit-bin inotify-tools
```

## Installation

The easiest way is to run the installation script from the root of the project:

```bash
chmod +x install.sh
sudo ./install.sh
```

Script:

- copies `pstoricohddst-gdi` to `/usr/lib/cups/filter/`;
- sets the rights `root:root` and `755`;
- copies `PPD` to `/usr/share/ppd/ricoh-sp111/`;
- restarts `cups`.

After that, add the printer through the CUPS web interface:

```text
http://localhost:631/
```

When selecting a driver, specify the appropriate `PPD`:

- `RICOH_Aficio_SP_111.ppd` for `SP 111`;
- `RICOH_Aficio_SP_100.ppd` for `SP 100`;
- `RICOH_Aficio_SP_204.ppd` for `SP 204`.

## Manual installation

If you don't want to use `install.sh`, you can set it manually:

```bash
sudo cp pstoricohddst-gdi /usr/lib/cups/filter/
sudo chown root:root /usr/lib/cups/filter/pstoricohddst-gdi
sudo chmod 755 /usr/lib/cups/filter/pstoricohddst-gdi

sudo mkdir -p /usr/share/ppd/ricoh-sp111
sudo cp RICOH_Aficio_SP_*.ppd /usr/share/ppd/ricoh-sp111/

sudo systemctl restart cups
```

## Diagnostics

Check if CUPS sees the printer:

```bash
lpstat -t
```

See if the filter is installed:

```bash
ls -l /usr/lib/cups/filter/pstoricohddst-gdi
```

Check dependencies:

```bash
which gs identify pbmtojbg inotifywait
```

Enable verbose CUPS logging:

```bash
sudo cupsctl --debug-logging
sudo systemctl restart cups
```

Submit test page:

```bash
lp -d ИМЯ_ПРИНТЕРА /usr/share/cups/data/testprint
```

View filter errors:

```bash
sudo grep -i "pstoricohddst-gdi\|ghostscript\|error\|unable" /var/log/cups/error_log | tail -n 50
```

## Notes

- The project is based on an old unofficial driver and is not supported by the manufacturer.
- For `Astra Linux 1.8` this fork has been tested to work with `Ricoh SP 111SU DDST`.
