require_relative 'camera_model'

class CameraMake
  attr_reader :name, :models, :images

  def initialize(name)
    @name = name
    @models = []
    @images = {}
  end

  def add_model(model_name)
    model = @models.first { |m| m.name == model_name }
    if model.nil?
      model = CameraModel.new(model_name)
      @models << model
    end
    model
  end

  def add_image(image)
    unless @images.has_key?(image.id)
      @images[image.id] = image
    end
  end

  private

  attr_writer :name, :models

end