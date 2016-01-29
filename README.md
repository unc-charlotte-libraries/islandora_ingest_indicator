# islandora_ingest_indicator

## Introduction

Designed to communicate Islandora ingest status to Archivists; a methodology for integrating Blink(1) indicator lights with an Islandora ingest server.   We have programmed Blink(1) to glow GREEN for indicating "ready for ingest" and RED for "ingest currently running".



### Requirements

* [Blink(1) indicator light](https://blink1.thingm.com/)


### Islandora Server Requirements

* Linux-based system or equivalent


## Concept

Goal: Detect the ingest status of an Islandora server and communicate the status to a Blink(1) indicator light device

How do we detect the ingest status?  Multiple methods are needed:

* Is drush currently running? (islandora_batch)
* Are files related to ingest currently being written to or open for reading+writing?

For our Islandora ingest system, we have re-routed ingest-related directories to a single "loading dock" drive.   These directories include:

* Drupal's "temporary" directory
* Fedora's "upload" directory
* islandora_bagit's output directories

The included "ingestwatcher.sh" script also watches Drupal's sites/default/files directory in an attempt to detect web-based ingests.


## Blink(1) Configuration

Blink(1) includes the [Blink1Control](http://blink1.thingm.com/blink1control/) desktop software, which can be configured to retrieve a URL every X seconds.   Your URL should point to a plain text file located on your Islandora ingest web server.

Blink(1) reads and responds to a hex encoded color contained in the plain text file.   Updating the plain text file with a hex color, updates the Blink(1) device's colors.

In Blink1Control software, you will find the URL retrieving function under the Tools tab.


## General Operation

The included "ingestwatcher.sh" employs "ps" to detect if drush is currently running, and "lsof" to detect files that are open for writing.

If Islandora ingest operations are detected, ingestwatcher.sh writes the hex color RED to a web-accessible plain text file.

If an Islandora ingest is not running, ingestwatcher.sh writes the hex color GREEN to the same web-accessible plain text file.


## Customization

* You can integrate Blink(1) support into other system scripts, such as nightly backup and server syncronication routines, just by echo'ing colors into the same web-accessible plain text file.  Besides GREEN and RED ingest indicator colors, we also communicate overall system status every morning when Archivist's arrive for work.  If a full system syncronization occurred overnight, we set Blink(1) to the color GOLD.  If only a partial, Drupal-only sync occured overnight, we set Blink(1) to the color BLUE.  Archivist's need not sift through their morning e-mails to determine the Islandora system status, they just have to look at their Blink(1) indicator light.   After they have settled into work, sat at 10:00 AM EST, our Blink(1) scripts shift from communicating overall Islandora system status to indicating only Islandora ingest status.
* Every bit of this methodology is ripe for customization; you will surely have your own ideas for detecting Islandora's ingest status.

## Inspiration

[Ghostbuster's Containment Unit, Ghost Ingest](https://www.youtube.com/watch?v=aLwKMkdVMnQ)


## Troubleshooting/Issues

* Watch your Apache access.log to ensure Blink1Control software is communicating successfully with your Islandora ingest web server.


## Maintainers

Current maintainers:

* [Brad Spry](https://github.com/bradspry)


## License

[GPLv3](http://www.gnu.org/licenses/gpl-3.0.txt)
