# lib/carrierwave/ffmpeg.rb
require 'streamio-ffmpeg'
module CarrierWave
  module FFMPEG
    module ClassMethods
      def resample( bitrate )
        process :resample => bitrate
      end
    end
 
    def resample
      directory = File.dirname( current_path )
      tmp_path = File.join( directory, "tmpfile" )
      new_path = File.join( directory, filename )
      FileUtils.mv( current_path, tmp_path )
      file = ::FFMPEG::Movie.new(tmp_path)
      file.transcode(new_path)
      FileUtils.mv( new_path,current_path )
      File.delete( tmp_path )
    end
  end
end
