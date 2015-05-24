class CameraModel
  attr_reader :name, :images

  # @param name Camera model name
  def initialize(name)
    @name = name
    @images = {}
  end

  # Adds an image to list
  # @param image CameraImage object
  def add_image(image)
    # checking for duplicates
    unless @images.has_key?(image.id)
      @images[image.id] = image
    end
  end

end