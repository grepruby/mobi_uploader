# lib/carrierwave/ffmpeg.rb
require 'streamio-ffmpeg'
module CarrierWave
  module FFMPEG

    def resample
      directory = File.dirname( current_path )
      tmp_path = File.join( directory, "tmpfile" )
      new_path = File.join( directory, filename )
      FileUtils.mv( current_path, tmp_path )
      file = ::FFMPEG::Movie.new(tmp_path)
      options = {audio_sample_rate: 11025, audio_channels: 1}
      file.transcode(new_path, options)
      FileUtils.mv( new_path,current_path )
      File.delete( tmp_path )
    end

  end
end
