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
  # "test.psd"                  => {format: "psd", dimensions: [17, 32]},
  # "exif_orientation.jpg"      => {format: "jpeg", dimensions: [600, 450]},
  # "infinite.jpg"              => {format: "jpeg", dimensions: [160, 240]},
  # "orient_2.jpg"              => {format: "jpeg", dimensions: [230, 408]},
  # "favicon.ico"               => {format: "ico", dimensions: [16, 16]},
  # "favicon2.ico"              => {format: "ico", dimensions: [32, 32]},
  # "man.ico"                   => {format: "ico", dimensions: [256, 256]},
  # "test.cur"                  => {format: "cur", dimensions: [32, 32]},
  # "webp_vp8x.webp"            => {format: "webp", dimensions: [386, 395]},
  # "webp_vp8l.webp"            => {format: "webp", dimensions: [386, 395]},
  # "webp_vp8.webp"             => {format: "webp", dimensions: [550, 368]},
  # "test.svg"                  => {format: "svg", dimensions: [200, 300]},
  # "test_partial_viewport.svg" => {format: "svg", dimensions: [860, 400]},
  # "test2.svg"                 => {format: "svg", dimensions: [366, 271]},
  # "test3.svg"                 => {format: "svg", dimensions: [255, 48]},
  # "test4.svg"                 => {format: "svg", dimensions: [271, 271]},
  # "orient_6.jpg"              => {format: "jpeg", dimensions: [1250, 2500]},
}

DOMAIN = "https://example.com/"

Spectator.describe FastImage do
  subject { FastImage }

  describe ".type" do
    context "remote files" do
      {% for path, data in VALID_IMAGES %}
        it "is expected to match format" do
          WebMock.stub(:get, Path[DOMAIN].join({{path}}).to_s).to_return(
            body_io: File.open("spec/support/" + {{path}})
          )

          expect(described_class.type(Path[DOMAIN].join({{path}}).to_s)).to eq({{ data[:format] }})

          WebMock.reset
        end
      {% end %}
    end

    context "local files" do
      {% for path, data in VALID_IMAGES %}
        it "is expected to match format" do
          expect(described_class.type(Path["spec/support/"].join({{path}}).to_s)).to eq({{ data[:format] }})
        end
      {% end %}
    end
  end

  describe ".dimensions" do
    context "remote files" do
      {% for path, data in VALID_IMAGES %}
        it "is expected to match format" do
          WebMock.stub(:get, Path[DOMAIN].join({{path}}).to_s).to_return(
            body_io: File.open("spec/support/" + {{path}})
          )

          expect(described_class.dimensions(Path[DOMAIN].join({{path}}).to_s)).to eq({{ data[:dimensions] }})

          WebMock.reset
        end
      {% end %}
    end

    context "local files" do
      {% for path, data in VALID_IMAGES %}
        it "is expected to match format" do
          expect(described_class.dimensions(Path["spec/support/"].join({{path}}).to_s)).to eq({{ data[:dimensions] }})
        end
      {% end %}
    end
  end
end
