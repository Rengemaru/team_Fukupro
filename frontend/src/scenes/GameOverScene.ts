import Phaser from 'phaser';
import { usePlayerStore } from '../store/playerStore';

export class GameOverScene extends Phaser.Scene {
  constructor() { super({ key: 'GameOverScene' }); }

  create() {
    const W = this.scale.width;
    const H = this.scale.height;

    // 暗い背景
    this.add.rectangle(W / 2, H / 2, W, H, 0x0a0a0f);

    // 背景のノイズ粒子
    for (let i = 0; i < 60; i++) {
      const x = Phaser.Math.Between(0, W);
      const y = Phaser.Math.Between(0, H);
      const r = Phaser.Math.Between(1, 3);
      this.add.circle(x, y, r, 0x222233, Phaser.Math.FloatBetween(0.1, 0.4));
    }

    // GAME OVER テキスト（赤・大）
    const title = this.add.text(W / 2, H * 0.32, 'GAME OVER', {
      fontSize: '72px',
      fontFamily: 'monospace',
      color: '#cc1111',
      stroke: '#440000',
      strokeThickness: 8,
    }).setOrigin(0.5).setAlpha(0);

    // サブテキスト
    const sub = this.add.text(W / 2, H * 0.50, '力尽きてしまった…', {
      fontSize: '24px',
      fontFamily: '"Yu Gothic","YuGothic",monospace',
      color: '#aaaaaa',
      stroke: '#000',
      strokeThickness: 2,
    }).setOrigin(0.5).setAlpha(0);

    // タイトルへ戻るボタン
    const btn = this.add.text(W / 2, H * 0.66, '[ タイトルへ戻る ]', {
      fontSize: '26px',
      fontFamily: 'monospace',
      color: '#aaddff',
      stroke: '#001144',
      strokeThickness: 2,
      backgroundColor: '#0d1a44',
      padding: { x: 24, y: 12 },
    }).setOrigin(0.5).setAlpha(0).setInteractive({ useHandCursor: true });

    btn.on('pointerover', () => btn.setColor('#ffffff'));
    btn.on('pointerout',  () => btn.setColor('#aaddff'));
    btn.on('pointerdown', () => {
      // HP をリセットしてタイトルへ
      usePlayerStore.getState().reset();
      this.cameras.main.fade(600, 0, 0, 0);
      this.time.delayedCall(600, () => this.scene.start('TitleScene'));
    });

    // フェードイン
    this.cameras.main.fadeIn(400);
    this.tweens.add({ targets: title, alpha: 1, duration: 600, ease: 'Power2' });
    this.tweens.add({ targets: sub,   alpha: 1, duration: 600, delay: 400, ease: 'Power2' });
    this.tweens.add({ targets: btn,   alpha: 1, duration: 600, delay: 800, ease: 'Power2' });

    // GAME OVER の点滅
    this.tweens.add({
      targets: title,
      alpha: 0.6,
      duration: 900,
      yoyo: true,
      repeat: -1,
      ease: 'Sine.easeInOut',
      delay: 1200,
    });
  }
}
