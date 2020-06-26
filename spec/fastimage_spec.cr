require "./spec_helper"

VALID_IMAGES = {
  "test.bmp"            => {format: "bmp", dimensions: {40, 27}},
  "test2.bmp"           => {format: "bmp", dimensions: {1920, 1080}},
  "test_coreheader.bmp" => {format: "bmp", dimensions: {40, 27}},
  "test_v5header.bmp"   => {format: "bmp", dimensions: {40, 27}},
  "test.gif"            => {format: "gif", dimensions: {17, 32}},
  "test.jpg"            => {format: "jpeg", dimensions: {882, 470}},
  "test2.jpg"           => {format: "jpeg", dimensions: {250, 188}},
  "test3.jpg"           => {format: "jpeg", dimensions: {630, 367}},
  "test4.jpg"           => {format: "jpeg", dimensions: {1485, 1299}},
  "infinite.jpg"        => {format: "jpeg", dimensions: {160, 240}},
  "test.png"            => {format: "png", dimensions: {30, 20}},
  "test.tiff"           => {format: "tiff", dimensions: {85, 67}},
  "test2.tiff"          => {format: "tiff", dimensions: {333, 225}},
  "test.psd"            => {format: "psd", dimensions: {17, 32}},
  "orient_2.jpg"        => {format: "jpeg", dimensions: {230, 408}},
  "favicon.ico"         => {format: "ico", dimensions: {16, 16}},
  "favicon2.ico"        => {format: "ico", dimensions: {32, 32}},
  "man.ico"             => {format: "ico", dimensions: {256, 256}},
  "test.cur"            => {format: "cur", dimensions: {32, 32}},
  "webp_vp8x.webp"      => {format: "webp", dimensions: {386, 395}},
  "webp_vp8l.webp"      => {format: "webp", dimensions: {386, 395}},
  "webp_vp8.webp"       => {format: "webp", dimensions: {550, 368}},
  # "test.svg"                  => {format: "svg", dimensions: {200, 300}},
  # "test_partial_viewport.svg" => {format: "svg", dimensions: {860, 400}},
  # "test2.svg"                 => {format: "svg", dimensions: {366, 271}},
  # "test3.svg"                 => {format: "svg", dimensions: {255, 48}},
  # "test4.svg"                 => {format: "svg", dimensions: {271, 271}},
  "orient_6.jpg"                               => {format: "jpeg", dimensions: {1250, 2500}},
  "exif-orientation/jpg/1.jpg"                 => {format: "jpeg", dimensions: {1240, 1754}},
  "exif-orientation/jpg/2.jpg"                 => {format: "jpeg", dimensions: {1240, 1754}},
  "exif-orientation/jpg/3.jpg"                 => {format: "jpeg", dimensions: {1240, 1754}},
  "exif-orientation/jpg/4.jpg"                 => {format: "jpeg", dimensions: {1240, 1754}},
  "exif-orientation/jpg/5.jpg"                 => {format: "jpeg", dimensions: {1240, 1754}},
  "exif-orientation/jpg/6.jpg"                 => {format: "jpeg", dimensions: {1240, 1754}},
  "exif-orientation/jpg/7.jpg"                 => {format: "jpeg", dimensions: {1240, 1754}},
  "exif-orientation/jpg/8.jpg"                 => {format: "jpeg", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt-rle/1.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt-rle/2.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt-rle/3.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt-rle/4.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt-rle/5.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt-rle/6.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt-rle/7.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt-rle/8.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt4/1.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt4/2.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt4/3.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt4/4.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt4/5.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt4/6.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt4/7.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-ccitt4/8.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg6/1.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg6/2.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg6/3.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg6/4.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg6/5.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg6/6.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg6/7.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg6/8.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg7/1.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg7/2.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg7/3.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg7/4.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg7/5.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg7/6.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg7/7.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-jpeg7/8.tif"          => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-bw/1.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-bw/2.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-bw/3.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-bw/4.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-bw/5.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-bw/6.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-bw/7.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-bw/8.tif"         => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-color/1.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-color/2.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-color/3.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-color/4.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-color/5.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-color/6.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-color/7.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-lzw-color/8.tif"      => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-packbits-color/1.tif" => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-packbits-color/2.tif" => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-packbits-color/3.tif" => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-packbits-color/4.tif" => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-packbits-color/5.tif" => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-packbits-color/6.tif" => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-packbits-color/7.tif" => {format: "tiff", dimensions: {1240, 1754}},
  "exif-orientation/tiff-packbits-color/8.tif" => {format: "tiff", dimensions: {1240, 1754}},
}

GZIPPED_IMAGES = {
  "gzipped.jpg"           => {format: "jpeg", dimensions: {970, 450}},
  "truncated_gzipped.jpg" => {format: "jpeg", dimensions: {970, 450}},
}

DOMAIN = "https://example.com/"

DATA_URIS = {
  "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAABCAYAAAD0In+KAAAAD0lEQVR42mNk+M9QzwAEAAmGAYCF+yOnAAAAAElFTkSuQmCC" => {format: "png", dimensions: {2, 1}},
}

Spectator.describe FastImage do
  describe ".type" do
    {% for path, data in VALID_IMAGES %}
      context "for remote .{{data[:format].id}}" do
        let(:url) { Path[DOMAIN].join({{path}}).to_s }
        let(:file) { File.open("spec/support/{{path.id}}") }

        it "is expected to match format" do
          WebMock.stub(:get, url).to_return(
            body_io: file
          )

          expect(described_class.type(url)).to eq({{ data[:format] }})

          WebMock.reset
        end
      end

      context "for local .{{data[:format].id}}" do
        let(:path) { Path["spec/support/"].join({{path}}).to_s }

        it "is expected to match format" do
          expect(described_class.type(path)).to eq({{ data[:format] }})
        end
      end

      context "for IOs" do
        let(:path) { Path["spec/support/"].join({{path}}).to_s }

        it "is expected to match format" do
          File.open(path) do |file|
            expect(described_class.type(file)).to eq({{ data[:format] }})
          end
        end

        it "is expected to match format when IO is readed" do
          File.open(path) do |file|
            file.gets_to_end
            expect(described_class.type(file)).to eq({{ data[:format] }})
          end
        end
      end
    {% end %}

    {% for path, data in DATA_URIS %}
      context "for data URIs" do
        it "is expected to match format" do
          expect(described_class.type({{path}})).to eq({{ data[:format] }})
        end
      end
    {% end %}

    # TODO: Specs with GZIPed content cannot be implemented now because of limitations in WebMock.
    #
    # {% for path, data in GZIPPED_IMAGES %}
    #   context "for remote gzipped .{{data[:format].id}}" do
    #     let(:url) { Path[DOMAIN].join({{path}}).to_s }
    #     let(:file) { File.open("spec/support/{{path.id}}") }

    #     it "is expected to match format" do
    #       WebMock.stub(:get, url).to_return(
    #         body_io: file, headers: HTTP::Headers{ "Content-Encoding" => "gzip", "Content-Type" => "image/jpeg"
    #       }
    #       )

    #       expect(described_class.type(url)).to eq({{ data[:format] }})

    #       WebMock.reset
    #     end
    #   end
    # {% end %}

    context "for not existing remote file" do
      let(:url) { Path[DOMAIN].join("does_not_exist").to_s }

      it "returns `nil`" do
        WebMock.stub(:get, url).to_return(status: 404)

        expect(described_class.type(url)).to be_nil

        WebMock.reset
      end
    end

    context "for unknown format" do
      let(:path) { Path["spec/support/"].join("test_rgb.ct").to_s }

      it "returns nil" do
        expect(described_class.type(path)).to be_nil
      end
    end
  end

  describe ".type!" do
    context "for unknown format" do
      let(:path) { Path["spec/support/"].join("test_rgb.ct").to_s }

      it "raises FastImage::UnknownTypeError" do
        expect { described_class.type!(path) }.to raise_error(FastImage::UnknownTypeError)
      end
    end
  end

  describe ".dimensions" do
    {% for path, data in VALID_IMAGES %}
      context "for remote .{{data[:format].id}}" do
        let(:url) { Path[DOMAIN].join({{path}}).to_s }
        let(:file) { File.open("spec/support/{{path.id}}") }

        it "is expected to match dimensions" do
          WebMock.stub(:get, url).to_return(
            body_io: file
          )

          expect(described_class.dimensions(url)).to eq({{ data[:dimensions] }})

          WebMock.reset
        end
      end

      context "for local .{{data[:format].id}}" do
        let(:path) { Path["spec/support/"].join({{path}}).to_s }

        it "is expected to match dimensions" do
          expect(described_class.dimensions(path)).to eq({{ data[:dimensions] }})
        end
      end

      context "for IOs" do
        let(:path) { Path["spec/support/"].join({{path}}).to_s }

        it "is expected to match dimensions" do
          File.open(path) do |file|
            expect(described_class.dimensions(file)).to eq({{ data[:dimensions] }})
          end
        end

        it "is expected to match dimensions when IO is readed" do
          File.open(path) do |file|
            file.gets_to_end
            expect(described_class.dimensions(file)).to eq({{ data[:dimensions] }})
          end
        end
      end
    {% end %}

    {% for path, data in DATA_URIS %}
      context "for data URIs" do
        it "is expected to match format" do
          expect(described_class.dimensions({{path}})).to eq({{ data[:dimensions] }})
        end
      end
    {% end %}

    context "for not existing remote file" do
      let(:url) { Path[DOMAIN].join("does_not_exist").to_s }

      it "returns `nil`" do
        WebMock.stub(:get, url).to_return(status: 404)

        expect(described_class.dimensions(url)).to be_nil

        WebMock.reset
      end
    end

    context "for unknown format" do
      let(:path) { Path["spec/support/"].join("test_rgb.ct").to_s }

      it "returns nil" do
        expect(described_class.dimensions(path)).to be_nil
      end
    end
  end

  describe ".dimensions!" do
    context "for unknown format" do
      let(:path) { Path["spec/support/"].join("test_rgb.ct").to_s }

      it "raises FastImage::UnknownTypeError" do
        expect { described_class.dimensions!(path) }.to raise_error(FastImage::UnknownTypeError)
      end
    end
  end
end
