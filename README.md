accdbexport
===========

[![Build
Status](https://travis-ci.org/jkennel/accdbexport.svg?branch=master)](https://travis-ci.org/jkennel/accdbexport)
[![Coverage
Status](https://img.shields.io/codecov/c/github/jkennel/accdbexport/master.svg)](https://codecov.io/github/jkennel/accdbexport?branch=master)

This package reads a Microsoft Access database (.accdb) using Jackcess
and outputs text files for each table (.csv).

Installation
============

    remotes::install_github('jkennel/accdbexport')

It only has one function.

    library(rJava)
    library(accdbexport)

    accdb_to_csv(path_to_accdb, path_to_output_folder)
