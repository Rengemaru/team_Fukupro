class BattleLogic
  def self.call(weather:, enemy:, enemy_current_hp:, player_hp:, player_max_hp:)
    new(
      weather:          weather,
      enemy:            enemy,
      enemy_current_hp: enemy_current_hp,
      player_hp:        player_hp,
      player_max_hp:    player_max_hp
    ).execute
  end

  def initialize(weather:, enemy:, enemy_current_hp:, player_hp:, player_max_hp:)
    @weather          = weather
    @enemy            = enemy
    @enemy_current_hp = enemy_current_hp
    @player_hp        = player_hp
    @player_max_hp    = player_max_hp
  end

  def execute
    player_dmg, player_result = calc_player_attack
    new_enemy_hp = [ @enemy_current_hp - player_dmg, 0 ].max

    # 敵HP が 0 以下 → win（敵反撃なし）
    if new_enemy_hp <= 0
      return build_result(
        player_dmg:    player_dmg,
        player_result: player_result,
        enemy_dmg:     0,
        enemy_result:  'hit',
        enemy_hp:      0,
        player_hp:     @player_hp,
        battle_result: 'win'
      )
    end

    # 敵反撃
    enemy_dmg, enemy_result = calc_enemy_attack(player_result)
    new_player_hp = [ @player_hp - enemy_dmg, 0 ].max
    battle_result = new_player_hp <= 0 ? 'game_over' : 'ongoing'

    build_result(
      player_dmg:    player_dmg,
      player_result: player_result,
      enemy_dmg:     enemy_dmg,
      enemy_result:  enemy_result,
      enemy_hp:      new_enemy_hp,
      player_hp:     new_player_hp,
      battle_result: battle_result
    )
  end

  private

  def calc_player_attack
    if @weather == 'cloudy'
      [ 0, 'miss' ]
    elsif @weather == @enemy.weakness_weather
      [ @enemy.attack_power * 3, 'hit' ]
    else
      [ @enemy.attack_power, 'hit' ]
    end
  end

  def calc_enemy_attack(player_result)
    damage = if player_result == 'hit' && @weather == @enemy.weakness_weather
               ( @enemy.attack_power * 0.5 ).floor
             else
               @enemy.attack_power
             end
    [ damage, 'hit' ]
  end

  def build_result(player_dmg:, player_result:, enemy_dmg:, enemy_result:, enemy_hp:, player_hp:, battle_result:)
    {
      player_attack:    { damage: player_dmg,  result: player_result },
      enemy_attack:     { damage: enemy_dmg,   result: enemy_result },
      enemy_current_hp: enemy_hp,
      player_current_hp: player_hp,
      battle_result:    battle_result,
    }
  end
end
