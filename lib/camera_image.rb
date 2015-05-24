class CameraImage

  attr_reader :thumbnails, :id

  # @param id Image id
  # @param thumbnails String array of images
  def initialize(id, thumbnails)
    @id = id
    @thumbnails = thumbnails
  end

end