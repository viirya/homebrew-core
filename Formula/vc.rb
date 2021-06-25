class Vc < Formula
  desc "SIMD Vector Classes for C++"
  homepage "https://github.com/VcDevel/Vc"
  url "https://github.com/VcDevel/Vc/releases/download/1.4.2/Vc-1.4.2.tar.gz"
  sha256 "50d3f151e40b0718666935aa71d299d6370fafa67411f0a9e249fbce3e6e3952"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "839b965a6be7efa1b509c0a8d353a04fbcc618c3af9463efd74277252f5fa302"
    sha256 cellar: :any_skip_relocation, big_sur:       "528735327505bd30c949c2028ee60fd9fd7858162f4c1ceab2418ba2d40f4b06"
    sha256 cellar: :any_skip_relocation, catalina:      "fc96abd9aab0fdd88d84cf0d56129b44d02fff3481078e332e4c3859661e66e6"
    sha256 cellar: :any_skip_relocation, mojave:        "01f676787da9756b8a2b9ba58041596002d9c1ae5c4fac683db8d4d8af6f0a8b"
  end

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", "-DBUILD_TESTING=OFF", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <Vc/Vc>

      using Vc::float_v;
      using Vec3D = std::array<float_v, 3>;

      float_v scalar_product(Vec3D a, Vec3D b) {
        return a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
       }

       int main(){
         return 0;
       }
    EOS
    system ENV.cc, "test.cpp", "-std=c++11", "-L#{lib}", "-lvc", "-o", "test"
    system "./test"
  end
end
