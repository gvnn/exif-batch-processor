require 'ox'
require_relative 'camera_make'
require_relative 'camera_model'
require_relative 'camera_image'

class ExifWorkParser < ::Ox::Sax

  def initialize(logger)
    @logger = logger
    @current_node = 'root'
    new_work
    @makes = {}
    @images = []
  end

  def get_parsed_data
    {:makes => @makes.sort.to_h, :images => @images}
  end

  def start_element(name)
    @current_node = name.to_s
    if name.to_s == 'work'
      new_work
    end
  end

  def end_element(name)
    if name.to_s == 'work'
      save_work
    end
  end

  def text(value)
    string_value = value.to_s
    case @current_node.to_s
      when 'id'
        @current_image_id = string_value
      when 'make'
        @current_make = string_value
      when 'model'
        @current_model = string_value
      when 'url'
        @current_image_thumbs << string_value
    end
  end

  private

  def new_work
    @current_make = 'UNKNOWN'
    @current_model = 'UNKNOWN'
    @current_image_id = 0
    if @current_image_thumbs.kind_of?(Array)
      @current_image_thumbs.clear()
    else
      @current_image_thumbs = []
    end
  end

  def save_work
    @logger.debug "Saving work #{@current_image_id}, #{@current_image_thumbs.count} images, make: #{@current_make}, model: #{@current_model}"
    # creating new make and model
    camera_make = add_make(@current_make)
    camera_model = camera_make.add_model(@current_model)
    # new image
    image = CameraImage.new(@current_image_id.to_i, @current_image_thumbs)
    @images << image
    # add image to make and models
    camera_make.add_image(image)
    camera_model.add_image(image)
  end

  def add_make(name)
    unless @makes.has_key?(name)
      camera_make = CameraMake.new(name)
      @makes[name] = camera_make
    else
      camera_make = @makes[name]
    end
    camera_make
  end

end