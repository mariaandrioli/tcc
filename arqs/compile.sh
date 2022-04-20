#!/bin/bash

pdflatex main
biber main
makeglossaries main
pdflatex main