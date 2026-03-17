import { create } from 'zustand'

export interface MapNode {
  id: number
  x: number
  y: number
  type: 'start' | 'enemy' | 'villager' | 'goal'
  connections: number[]
  completed: boolean
  village_event?: string | null
}

type GameStore = {
  nodes: MapNode[]
  playerNodeId: number
  completedNodes: number[]
  setNodes: (nodes: MapNode[]) => void
  setPlayerNodeId: (id: number) => void
  setCompletedNodes: (ids: number[]) => void
  reset: () => void
}

export const useGameStore = create<GameStore>((set) => ({
  nodes: [],
  playerNodeId: 0,
  completedNodes: [],
  setNodes: (nodes) => set({ nodes }),
  setPlayerNodeId: (playerNodeId) => set({ playerNodeId }),
  setCompletedNodes: (completedNodes) => set({ completedNodes }),
  reset: () => set({ nodes: [], playerNodeId: 0, completedNodes: [] }),
}))
