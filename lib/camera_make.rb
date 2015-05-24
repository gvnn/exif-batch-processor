require_relative 'camera_model'

class CameraMake
  attr_reader :name, :models, :images

  # @param name Make name
  def initialize(name)
    @name = name
    @models = []
    @images = {}
  end

  # Adds a new camera model
  # @param model_name String model name
  def add_model(model_name)
    # look for a model with same same
    model = @models.first { |m| m.name == model_name }
    if model.nil?
      # not found, new model
      model = CameraModel.new(model_name)
      @models << model
    end
    # return model
    model
  end

  # Adds a new image object to the images list.
  # @param image CameraImage object
  def add_image(image)
    # checking for duplicates
    unless @images.has_key?(image.id)
      # add to hash map
      @images[image.id] = image
    end
  end

  private

  attr_writer :name, :models

end