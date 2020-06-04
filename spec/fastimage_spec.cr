require "./spec_helper"

VALID_IMAGES = {
  "test.bmp"            => {format: "bmp", dimensions: [40, 27]},
  "test2.bmp"           => {format: "bmp", dimensions: [1920, 1080]},
  "test_coreheader.bmp" => {format: "bmp", dimensions: [40, 27]},
  "test_v5header.bmp"   => {format: "bmp", dimensions: [40, 27]},
  "test.gif"            => {format: "gif", dimensions: [17, 32]},
  "test.jpg"            => {format: "jpeg", dimensions: [882, 470]},
  "test.png"            => {format: "png", dimensions: [30, 20]},
  "test2.jpg"           => {format: "jpeg", dimensions: [250, 188]},
  "test3.jpg"           => {format: "jpeg", dimensions: [630, 367]},
  "test4.jpg"           => {format: "jpeg", dimensions: [1485, 1299]},
  # "test.tiff"                 => {format: "tiff", dimensions: [85, 67]},
  # "test2.tiff"                => {format: "tiff", dimensions: [333, 225]},
  "test.psd"                  => {format: "psd", dimensions: [17, 32]},
  # "exif_orientation.jpg"      => {format: "jpeg", dimensions: [600, 450]},
  "infinite.jpg"              => {format: "jpeg", dimensions: [160, 240]},
  # "orient_2.jpg"              => {format: "jpeg", dimensions: [230, 408]},
  "favicon.ico"               => {format: "ico", dimensions: [16, 16]},
  "favicon2.ico"              => {format: "ico", dimensions: [32, 32]},
  "man.ico"                   => {format: "ico", dimensions: [256, 256]},
  "test.cur"                  => {format: "cur", dimensions: [32, 32]},
  "webp_vp8x.webp"            => {format: "webp", dimensions: [386, 395]},
  "webp_vp8l.webp"            => {format: "webp", dimensions: [386, 395]},
  "webp_vp8.webp"             => {format: "webp", dimensions: [550, 368]},
  # "test.svg"                  => {format: "svg", dimensions: [200, 300]},
  # "test_partial_viewport.svg" => {format: "svg", dimensions: [860, 400]},
  # "test2.svg"                 => {format: "svg", dimensions: [366, 271]},
  # "test3.svg"                 => {format: "svg", dimensions: [255, 48]},
  # "test4.svg"                 => {format: "svg", dimensions: [271, 271]},
  # "orient_6.jpg"              => {format: "jpeg", dimensions: [1250, 2500]},
}

DOMAIN = "https://example.com/"

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
    {% end %}

    {% for path, data in VALID_IMAGES %}
      context "for local .{{data[:format].id}}" do
        let(:path) { Path["spec/support/"].join({{path}}).to_s }

        it "is expected to match format" do
          expect(described_class.type(path)).to eq({{ data[:format] }})
        end
      end
    {% end %}

    context "for not existing remote file" do
      let(:url) { Path[DOMAIN].join("does_not_exist").to_s }

      it "returns `nil`" do
        WebMock.stub(:get, url).to_return(status: 404)

        expect(described_class.type(url)).to be_nil

        WebMock.reset
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
    {% end %}

    {% for path, data in VALID_IMAGES %}
      context "for local .{{data[:format].id}}" do
        let(:path) { Path["spec/support/"].join({{path}}).to_s }

        it "is expected to match dimensions" do
          expect(described_class.dimensions(path)).to eq({{ data[:dimensions] }})
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
  end
end