module Api
  class WeatherController < ApplicationController
    def create
      frames = params.require(:frames).map do |f|
        f.permit(:rms, :zcr, :spectral_centroid, :spectral_rolloff,
                 :spectralCentroid, :spectralRolloff).to_h.symbolize_keys
      end

      classifier = WeatherClassifier.new(frames)
      weather = classifier.classify
      Rails.logger.debug("WeatherClassifier avg: #{classifier.debug_avg}")
      render json: { weather: }
    end
  end
end
