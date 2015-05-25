require_relative 'spec_helper'

describe 'CameraMake Unit tests' do

  it 'should add a new model' do
    camera_make = CameraMake.new(Faker::Company.name)
    (0..4).each do
      camera_make.add_model(Faker::Commerce.product_name)
    end
    camera_make.models.count.should eql 5
  end

  it "shouldn't add duplicate models" do
    camera_make = CameraMake.new(Faker::Company.name)
    (0..4).each do
      camera_make.add_model("test")
    end
    camera_make.models.count.should eql 1
  end

  it 'should add a new image' do

    camera_make = CameraMake.new(Faker::Company.name)
    (0..4).each do
      camera_make.add_image(CameraImage.new(Faker::Number.number(10), []))
    end
    camera_make.images.count.should eql 5

  end

  it "shouldn't add duplicate images" do

    camera_make = CameraMake.new(Faker::Company.name)
    (0..4).each do
      camera_make.add_image(CameraImage.new(1, []))
    end
    camera_make.images.count.should eql 1

  end

end