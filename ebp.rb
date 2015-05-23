#!/usr/bin/env ruby
require 'thor'
require_relative 'lib/exif_processor'

class ExifProcessorConsole < Thor

  desc 'gen', 'Generates html files'

  option :i,
         :banner => '[INPUT DIR]',
         :default => './data/input',
         :type => :string,
         :required => true,
         :desc => 'location of the XML input file'

  option :o,
         :banner => '[OUTPUT DIR]',
         :default => './data/output',
         :type => :string,
         :required => true,
         :desc => 'output directory'

  option :e,
         :banner => '[EXIF FILE NAME]',
         :required => true,
         :default => 'exif.xml',
         :desc => 'EXIF data file name',
         :type => :string

  def gen
    ebp = ExifProcessor.new(options)
    ebp.process_xml_file
  end

end

ExifProcessorConsole.start