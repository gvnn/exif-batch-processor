require_relative 'spec_helper'

describe 'ExifWorkParser Unit tests' do

  it 'should add 2 makes 2 models and 2 images, 6 thumbnails' do

    handler = ExifWorkParser.new(Logger.new($stdout))

    io = StringIO.new(%{
<works>
  <work>
    <id>31820</id>
    <urls>
      <url type="small">http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg</url>
      <url type="medium">http://ih1.redbubble.net/work.31820.1.flat,300x300,075,f.jpg</url>
      <url type="large">http://ih1.redbubble.net/work.31820.1.flat,550x550,075,f.jpg</url>
    </urls>
    <exif>
      <model>NIKON D80</model>
      <make>NIKON CORPORATION</make>
    </exif>
  </work>
  <work>
    <id>2041</id>
    <urls>
      <url type="small">http://ih1.redbubble.net/work.2041.1.flat,135x135,075,f.jpg</url>
      <url type="medium">http://ih1.redbubble.net/work.2041.1.flat,300x300,075,f.jpg</url>
      <url type="large">http://ih1.redbubble.net/work.2041.1.flat,550x550,075,f.jpg</url>
    </urls>
    <exif>
      <model>Canon EOS 20D</model>
      <make>Canon</make>
    </exif>
  </work>
</works>
})

    Ox.sax_parse(handler, io)

    data = handler.get_parsed_data

    data[:makes].count.should eql 2

    # results are ordered by make name
    data[:makes].values[1].name.should eql 'NIKON CORPORATION'
    data[:makes].values[0].name.should eql 'Canon'

    (0..1).each do |i|
      data[:makes].values[i].models.count.should eql 1
      data[:makes].values[i].images.count.should eql 1
      # there should be 3 thumbnails
      data[:makes].values[i].images.values[0].thumbnails.length.should eql 3
    end

  end

end