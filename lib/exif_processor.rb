require 'logger'
require_relative 'exif_work'

class ExifProcessor

  def initialize(options)
    @logger = Logger.new($stdout)

    # command line options
    @input_folder = options[:i]
    @output_folder = options[:o]
    @exif_file_name = options[:e]

    # file paths
    @exif_file_full_path = "#{@input_folder}/#{@exif_file_name}"

  end

  def process_xml_file
    @logger.debug @exif_file_full_path
    #check files exists
    if File.file?(@exif_file_full_path)
      import_exif_works
      clean_output_folder
      generate_files
      copy_static_files
    else
      @logger.error "Can't find file #{@exif_file_full_path}"
      false
    end
  end

  def copy_static_files
    # code here
  end

  def generate_files
    # code here
  end

  def clean_output_folder
    # code here
  end

  def import_exif_works
    handler = ExifWork.new()
    input = File.open(@exif_file_full_path)
    Ox.sax_parse(handler, input)
  end

end