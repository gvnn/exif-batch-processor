require 'logger'
require_relative 'exif_work_parser'
require 'erb'
require 'tilt/erb'

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
    @logger.debug "Processing #{@exif_file_full_path}"
    #check files exists
    if File.file?(@exif_file_full_path)
      parsed_data = import_exif_works
      clean_output_folder
      generate_files(parsed_data)
      copy_assets
      @logger.debug "Complete!"
    else
      @logger.error "Can't find file #{@exif_file_full_path}"
      false
    end
  end

  private

  def copy_assets
    static_output_folder = "#{@output_folder}/assets"
    @logger.debug "Copying static assets to #{static_output_folder}"
    unless File.directory?(static_output_folder)
      FileUtils.mkdir_p(static_output_folder)
    end
    FileUtils.cp_r(Dir["res/components/bootstrap/dist/css/bootstrap.min.css"], static_output_folder)
    FileUtils.cp_r(Dir["res/assets/*"], static_output_folder)
  end

  def generate_files(data)
    @logger.debug 'Starting rendering'
    # generate the index
    render('index', data, 'index')
    # generate the make files
    data[:makes].each {
        |key, value|
      render('make', {:make => value}, value.name.to_slug)
      # generate the model files
      value.models.each { |model| render('model', {:model => model, :make => value}, "#{value.name.to_slug}-#{model.name.to_slug}") }
    }
    @logger.debug 'Render complete'
  end

  def clean_output_folder
    @logger.debug "Clean output folder #{@output_folder}"
    FileUtils.rm Dir.glob("#{@output_folder}/*.html")
    FileUtils.rm_rf Dir.glob("#{@output_folder}/assets")
  end

  def import_exif_works
    @logger.debug 'Start parsing'
    handler = ExifWorkParser.new(@logger)
    input = File.open(@exif_file_full_path)
    Ox.sax_parse(handler, input)
    @logger.debug 'Parsing complete'
    handler.get_parsed_data
  end

  def render(template, data, filename)
    @logger.debug "Rendering template #{template} >> #{filename}"
    template = Tilt::ERBTemplate.new("res/templates/#{template}.html.erb")
    File.open(File.join(@output_folder, "#{filename}.html"), "w") do |f|
      f << template.render(Object.new, data)
    end
  end

end