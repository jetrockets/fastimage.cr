require "./spec_helper"

VALID_IMAGES = {
  "test.bmp"                  => {format: "bmp", size: [40, 27]},
  "test2.bmp"                 => {format: "bmp", size: [1920, 1080]},
  "test_coreheader.bmp"       => {format: "bmp", size: [40, 27]},
  "test_v5header.bmp"         => {format: "bmp", size: [40, 27]},
  "test.gif"                  => {format: "gif", size: [17, 32]},
  "test.jpg"                  => {format: "jpeg", size: [882, 470]},
  "test.png"                  => {format: "png", size: [30, 20]},
  "test2.jpg"                 => {format: "jpeg", size: [250, 188]},
  "test3.jpg"                 => {format: "jpeg", size: [630, 367]},
  "test4.jpg"                 => {format: "jpeg", size: [1485, 1299]},
  "test.tiff"                 => {format: "tiff", size: [85, 67]},
  "test2.tiff"                => {format: "tiff", size: [333, 225]},
  "test.psd"                  => {format: "psd", size: [17, 32]},
  "exif_orientation.jpg"      => {format: "jpeg", size: [600, 450]},
  "infinite.jpg"              => {format: "jpeg", size: [160, 240]},
  "orient_2.jpg"              => {format: "jpeg", size: [230, 408]},
  "favicon.ico"               => {format: "ico", size: [16, 16]},
  "favicon2.ico"              => {format: "ico", size: [32, 32]},
  "man.ico"                   => {format: "ico", size: [256, 256]},
  "test.cur"                  => {format: "cur", size: [32, 32]},
  "webp_vp8x.webp"            => {format: "webp", size: [386, 395]},
  "webp_vp8l.webp"            => {format: "webp", size: [386, 395]},
  "webp_vp8.webp"             => {format: "webp", size: [550, 368]},
  "test.svg"                  => {format: "svg", size: [200, 300]},
  "test_partial_viewport.svg" => {format: "svg", size: [860, 400]},
  "test2.svg"                 => {format: "svg", size: [366, 271]},
  "test3.svg"                 => {format: "svg", size: [255, 48]},
  "test4.svg"                 => {format: "svg", size: [271, 271]},
  "orient_6.jpg"              => {format: "jpeg", size: [1250, 2500]},
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
end
