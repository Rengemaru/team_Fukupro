import React from "react"

type WeatherType = "sunny" | "rain" | "thunder" | "wind" | "hail"

type WeatherIconProps = {
  weather: WeatherType
}

const ICONS: Record<WeatherType, string> = {
  sunny: "☀️",
  rain: "🌧️",
  thunder: "⛈️",
  wind: "💨",
  hail: "🌨️",
}

const LABEL: Record<WeatherType, string> = {
  sunny: "晴れ",
  rain: "雨",
  thunder: "雷",
  wind: "強風",
  hail: "雹",
}

const WeatherIcon: React.FC<WeatherIconProps> = ({ weather }) => {
  return (
    <div
      style={{
        display: "inline-flex",
        flexDirection: "column",
        alignItems: "center",
        gap: 6,
        fontFamily: "sans-serif",
      }}
    >
      <div
        style={{
          fontSize: 48,
          width: 96,
          height: 96,
          borderRadius: 24,
          display: "grid",
          placeItems: "center",
          background: "#f7f7f7",
          border: "1px solid #ddd",
          boxShadow: "2px 2px 8px rgba(0,0,0,0.08)",
        }}
      >
        {ICONS[weather]}
      </div>
      <div style={{ fontSize: 14, fontWeight: 600 }}>{LABEL[weather]}</div>
    </div>
  )
}

export type { WeatherType }
export default WeatherIcon
