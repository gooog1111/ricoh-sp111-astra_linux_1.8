<!-- LANG_START -->
🇬🇧 [English version](README.en.md)
<!-- LANG_END -->

<div align="center">

<img src="resources/header.svg" alt="Ricoh Aficio SP-111 Driver" width="900"/>

</div>





<!-- STATS_START -->
<!-- auto-updated by GitHub Actions · 2026-07-05 19:01 UTC -->

[![Views local](https://img.shields.io/badge/Views_local-172-ff6900?style=for-the-badge&logo=github)](https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8)
[![Views GitHub](https://img.shields.io/badge/Views_GitHub-4-ff6900?style=for-the-badge&logo=github)](https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8)
[![Unique visitors](https://img.shields.io/badge/Unique-2-blue?style=for-the-badge&logo=github)](https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8)
[![Clones](https://img.shields.io/badge/Clones-967-purple?style=for-the-badge&logo=github)](https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8)
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
<!-- auto-updated by GitHub Actions · 2026-07-05 19:01 UTC -->

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
<summary><b>Открытые issues</b></summary>


<p align="center">
  <b>Открытых issues нет.</b><br>
  <sub>Служебный issue <code>views-counter</code> скрыт из списка.</sub>
</p>


</details>

<p>
  <a href="https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8/issues/new/choose">Создать issue</a> ·
  <a href="https://github.com/gooog1111/ricoh-sp111-astra_linux_1.8/issues">Все issues</a>
</p>

<!-- ISSUES_END -->




## Драйвер Ricoh Aficio SP-111

Это форк старого драйвера `pstoricohddst-gdi` для принтеров серии `Ricoh SP 100/111/204 DDST`.

В этом форке:

- исправлена работа фильтра на современных `CUPS` и `Ghostscript`;
- отключен нестабильный асинхронный режим через `inotifywait`;
- временные файлы создаются в `/var/spool/cups/tmp`, что лучше работает в `Astra Linux`;
- включено более удобное отладочное логирование;
- добавлен `install.sh` для установки из текущей папки проекта.

## Состав

- `pstoricohddst-gdi` — фильтр CUPS;
- `RICOH_Aficio_SP_100.ppd` — PPD для SP 100;
- `RICOH_Aficio_SP_111.ppd` — PPD для SP 111;
- `RICOH_Aficio_SP_204.ppd` — PPD для SP 204;
- `check-requirements` — проверка зависимостей;
- `install.sh` — установка фильтра и PPD из относительного пути.

## Зависимости

Проверьте наличие зависимостей:

```bash
./check-requirements
```

Если чего-то не хватает, установите пакеты:

```bash
sudo apt update
sudo apt install cups ghostscript imagemagick jbigkit-bin inotify-tools
```

## Установка

Самый простой способ — запустить установочный скрипт из корня проекта:

```bash
chmod +x install.sh
sudo ./install.sh
```

Скрипт:

- копирует `pstoricohddst-gdi` в `/usr/lib/cups/filter/`;
- выставляет права `root:root` и `755`;
- копирует `PPD` в `/usr/share/ppd/ricoh-sp111/`;
- перезапускает `cups`.

После этого добавьте принтер через веб-интерфейс CUPS:

```text
http://localhost:631/
```

При выборе драйвера укажите подходящий `PPD`:

- `RICOH_Aficio_SP_111.ppd` для `SP 111`;
- `RICOH_Aficio_SP_100.ppd` для `SP 100`;
- `RICOH_Aficio_SP_204.ppd` для `SP 204`.

## Ручная установка

Если не хотите использовать `install.sh`, можно установить вручную:

```bash
sudo cp pstoricohddst-gdi /usr/lib/cups/filter/
sudo chown root:root /usr/lib/cups/filter/pstoricohddst-gdi
sudo chmod 755 /usr/lib/cups/filter/pstoricohddst-gdi

sudo mkdir -p /usr/share/ppd/ricoh-sp111
sudo cp RICOH_Aficio_SP_*.ppd /usr/share/ppd/ricoh-sp111/

sudo systemctl restart cups
```

## Диагностика

Проверить, видит ли CUPS принтер:

```bash
lpstat -t
```

Посмотреть, установлен ли фильтр:

```bash
ls -l /usr/lib/cups/filter/pstoricohddst-gdi
```

Проверить зависимости:

```bash
which gs identify pbmtojbg inotifywait
```

Включить подробный лог CUPS:

```bash
sudo cupsctl --debug-logging
sudo systemctl restart cups
```

Отправить тестовую страницу:

```bash
lp -d ИМЯ_ПРИНТЕРА /usr/share/cups/data/testprint
```

Посмотреть ошибки фильтра:

```bash
sudo grep -i "pstoricohddst-gdi\|ghostscript\|error\|unable" /var/log/cups/error_log | tail -n 50
```

## Примечания

- Проект основан на старом неофициальном драйвере и не поддерживается производителем.
- Для `Astra Linux 1.8` этот форк проверен на рабочую печать с `Ricoh SP 111SU DDST`.
