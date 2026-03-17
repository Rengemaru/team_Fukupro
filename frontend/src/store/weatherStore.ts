import { create } from 'zustand'

type WeatherStore = {
  weather: string | null
  setWeather: (weather: string) => void
}

export const useWeatherStore = create<WeatherStore>((set) => ({
  weather: null,
  setWeather: (weather) => set({ weather }),
}))
