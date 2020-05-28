# HadesPrerequisites
An R package that will only install successfully if all Hades system dependencies have been properly installed an configured.



HadesPrerequisites
============

Introduction
=============
An R package that will only install successfully if all Hades system dependencies have been properly installed an configured. This is a backend package used by the Hades package that users should not need to install or interact with explicitly. HadesPrerequisites contains an R script that runs a series of tests. The package will only install if all tests pass. If HadesPrerequisites installs successfully then all system dependencies are met and the HADES/OHDSI methods libraries should install without error.

Features
========
- Eases HADES installation pains by ensuring that system dependencies are met
- Backend package that users should not need to interact with or install explicitly

Technology
==========
HadesPrerequisites is an R package.

System Requirements
===================
The system requirements for HadesPrerequisites are exactly the [system requirements for the HADES R package ecosystem](https://ohdsi.github.io/Hades/rSetup.html). These are

- R version 3.1(?) or later
- RTools
- Java versions (32 or 64 bit) that matches the installed R versions (32 or 64 bit)

Installation
============
This package should normally not be installed as a standalone package. It will be installed automatically when users install the Hades package.

User Documentation
==================
There is currently no documentation for HadesPrerequisites since it is a very simple backend package. As the package matures documentation will be added.

Support
=======
This package is in development. Submit suggestions or issues at https://github.com/ablack3/HadesPrerequisites/issues
 
 
License
=======
HadesPrerequisites is licensed under Apache License 2.0

Development
===========
HadesPrerequisites is being developed in R Studio.

### Development status

pre-Alpha
