# lib/carrierwave/ffmpeg.rb
require 'streamio-ffmpeg'
module CarrierWave
  module FFMPEG
    module ClassMethods
      def resample( bitrate )
        process :resample => bitrate
      end
    end
 
    def resample( bitrate )
      directory = File.dirname( current_path )
      tmp_path   = File.join( directory, "tmpfile" )
      FileUtils.mv( current_path, tmp_path )
      file = ::FFMPEG::Movie.new(tmp_path)
      file.transcode(directory + "/format_conversion_#{filename}")

      File.delete( tmp_path )

    end
  end
end
