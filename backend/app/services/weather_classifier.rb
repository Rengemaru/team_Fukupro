class WeatherClassifier
  # 閾値定数
  RMS_HIGH               = 0.5
  RMS_MID                = 0.3
  SPECTRAL_CENTROID_HIGH = 3000.0
  SPECTRAL_CENTROID_LOW  = 2000.0
  ZCR_HIGH               = 0.3

  # @param frames [Array<Hash>] 特徴量フレームの配列
  #   例: [{ rms: 0.6, zcr: 0.3, spectral_centroid: 3200.0, spectral_rolloff: 4800.0 }, ...]
  def initialize(frames)
    @frames = frames
  end

  # 各フレームの平均値をもとに天候を分類して返す
  # @return [String] 天候種別
  def classify
    return "cloudy" if @frames.empty?

    avg = average_features

    if avg[:rms] > RMS_HIGH && avg[:spectral_centroid] > SPECTRAL_CENTROID_HIGH
      "thunderstorm"
    elsif avg[:rms] > RMS_MID && avg[:zcr] > ZCR_HIGH
      "wind"
    elsif avg[:rms] > RMS_MID && avg[:spectral_centroid] < SPECTRAL_CENTROID_LOW
      "fog"
    elsif avg[:rms] > RMS_MID
      "rain"
    else
      "cloudy"
    end
  end

  private

  # 全フレームの各特徴量の平均値を計算する
  # @return [Hash] { rms:, zcr:, spectral_centroid:, spectral_rolloff: }
  def average_features
    count = @frames.size.to_f
    {
      rms:               @frames.sum { |f| f[:rms].to_f } / count,
      zcr:               @frames.sum { |f| f[:zcr].to_f } / count,
      spectral_centroid: @frames.sum { |f| f[:spectral_centroid].to_f } / count,
      spectral_rolloff:  @frames.sum { |f| f[:spectral_rolloff].to_f } / count
    }
  end
end
