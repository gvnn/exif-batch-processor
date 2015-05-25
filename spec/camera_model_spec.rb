require_relative 'spec_helper'

describe 'CameraModel Unit tests' do

  it 'should add a new image' do

    camera_model = CameraModel.new(Faker::Commerce.product_name)
    (0..4).each do
      camera_model.add_image(CameraImage.new(Faker::Number.number(10), []))
    end
    camera_model.images.count.should eql 5

  end

  it "shouldn't add duplicates" do

    camera_model = CameraModel.new(Faker::Commerce.product_name)
    (0..4).each do
      camera_model.add_image(CameraImage.new(1, []))
    end
    camera_model.images.count.should eql 1

  end

end