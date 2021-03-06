# EXIF Batch Processor

[![Build Status](https://travis-ci.org/gvnn/exif-batch-processor.svg)](https://travis-ci.org/gvnn/exif-batch-processor)

Batch processor that takes the input file and produces a single HTML file for each camera make, camera model and also an index.


The index HTML page contains:

- Thumbnail images for the first 10 work
- Navigation that allows the user to browse to all camera makes

Each Camera Make HTML page contains

- Thumbnail images of the first 10 works for that camera make
- Navigation that allows the user to browse to the index page and to all camera models of that make

Each Camera Model HTML page contains

- Thumbnail images of all works for that camera make and model
- Navigation that allows the user to browse to the index page and the camera make

## Dependencies, Test and Run

The application requires [bundler](http://bundler.io) and [bower](http://bower.io)

- Dependencies install: `bundle install && bower install`

- Test: `rspec`

- Command line: `./ebp.rb help`

- Sample: `./ebp.rb gen -e exif_sample.xml -i data/input -o data/output`