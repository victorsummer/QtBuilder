require 'net/http'
require 'uri'
require 'progressbar'
require 'rubygems'
require 'zip'

def download_file(url, filename, download_title, mode = 'wb')
  url_base = url.split('/')[2]
  url_path = '/'+url.split('/')[3..-1].join('/')
  url_path.gsub!('%20', ' ')
  @counter = 0

  Net::HTTP.start(url_base) do |http|
    response = http.request_head(URI.escape(url_path))
    ProgressBar
    pbar = ProgressBar.new(download_title, response['content-length'].to_i)
    File.open(filename, mode) { |f|
      http.get(URI.escape(url_path)) do |str|
        f << str
        @counter += str.length
        pbar.set(@counter)
      end
      f.close
    }
    pbar.finish
  end
end

def download_file2(url, filename, download_title, mode = 'wb')
  uri = URI(url)
  url_path = '/'+url.split('/')[3..-1].join('/')
  @counter = 0
  Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    response = http.request_head(URI.escape(url_path))
    ProgressBar
    pbar = ProgressBar.new(download_title, response['content-length'].to_i)
    request = Net::HTTP::Get.new uri
    http.request request do |response|
      File.open filename, mode do |io|
        response.read_body do |chunk|
          io.write chunk
          @counter += chunk.length
          pbar.set(@counter)
        end
      end
    end
    pbar.finish
  end
end

if system("bundle --version")
  puts "bundler is installed"
else
  system('gem', 'install', 'bundler')
end
system('bundle')

puts "Checking if ssl cerficate file exists"
if File.exist?("C:\\Ruby22\\cacert.pem")
  puts "SSL certificate file is installed"
else
  puts "Downloading SSL cerficate file"
  download_file("http://curl.haxx.se/ca/cacert.pem", "cacert.pem", "SSL cert")
  puts "SSL cerficate file downloaded"
  puts "Move cacert.pem to C:/Ruby22"
  FileUtils.mv("cacert.pem", "C:\\Ruby22\\cacert.pem")
end

puts "Checking if 7z is installed"

seven_zip = ""
if system("7z --version")
  seven_zip = "7z"
  puts "7z is installed"
elsif File.exist?("C:\\Program Files (x86)\\7-Zip\\7z.exe")
  puts "7z is installed without adding it to environment path"
  seven_zip = "C:\\Program Files (x86)\\7-Zip\\7z.exe"
else
  puts "7z is not installed"
  puts "Downloading 7z"
  download_file("http://ncu.dl.sourceforge.net/project/sevenzip/7-Zip/9.20/7z920.msi", "7z920.msi", "7z installer")
  puts "7z Downloaded"

  puts "Installing 7z"
  system("msiexec /qn /i 7z920.msi")
  seven_zip = "C:\\Program Files (x86)\\7-Zip\\7z.exe"
  system("del 7z920.msi")
  puts "7z installed"
end

puts "Checking if python is installed"
if system("python --version")
  puts "python is installed"
else
  puts "python is not installed"
  puts "Downloading python"
  download_file2("https://www.python.org/ftp/python/3.4.3/python-3.4.3.msi", "python-3.4.3.msi", "python installer")
  puts "python Downloaded"

  puts "Installing python"
  system("msiexec /qn /i python-3.4.3.msi")
  system("del python-3.4.3.msi")
  puts "python installed"
end

puts "Checking if perl is installed"
if system("perl --version")
  puts "perl is installed"
else
  puts "perl is not installed"
  puts "Downloading perl"
  download_file("http://downloads.activestate.com/ActivePerl/releases/5.20.2.2001/ActivePerl-5.20.2.2001-MSWin32-x86-64int-298913.msi", "ActivePerl-5.20.2.2001-MSWin32-x86-64int-298913.msi", "perl installer")
  puts "perl Downloaded"

  puts "Installing perl"
  system("msiexec /qn /i ActivePerl-5.20.2.2001-MSWin32-x86-64int-298913.msi")
  system("del ActivePerl-5.20.2.2001-MSWin32-x86-64int-298913.msi")
  puts "perl installed"
end

puts "Checking if mingw is installed"
if system('mingw32-make --version')
  puts "mingw is installed"
else
  puts "mingw is not installed"
  puts "Downloading mingw"
  download_file("http://jaist.dl.sourceforge.net/project/mingw-w64/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/4.9.1/threads-posix/dwarf/i686-4.9.1-release-posix-dwarf-rt_v3-rev2.7z", "mingw.7z", "mingw")
  puts "mingw Downloaded"

  puts "Installing mingw"
  system(seven_zip, 'x', "-oc:\\", '-y', 'mingw.7z')
  system("del mingw.7z")
  puts "mingw installed"
end

puts "Checking if gles sdk is installed"
if Dir.exist?("c:/gles_sdk")
  puts "gles sdk is installed"
else
  puts "gles sdk is not installed"
  puts "Downloading gles sdk"
  download_file("http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2012/10/gles_sdk.zip", "gles_sdk.zip", "gles sdk")
  puts "gles sdk Downloaded"

  puts "Installing gles sdk"
  system(seven_zip, 'x', "-oc:\\", '-y', 'gles_sdk.zip')
  system("del gles_sdk.zip")
  puts "gles sdk installed"
end

puts "Checking if Qt is downloaded"
if File.exist?("qt-source.7z")
  puts "Qt is downloaded"
else
  puts "Qt is not downloaded"
  puts "Downloading Qt source code"
  download_file("http://mirror.bit.edu.cn/qtproject/official_releases/qt/5.4/5.4.1/single/qt-everywhere-opensource-src-5.4.1.7z", "qt-source.7z", "qt-source")
  puts "Qt Downloaded"
end

system(seven_zip, 'x', '-o./', '-y', 'qt-source.7z')
puts "Qt Extracted"
system("del qt-source.7z")