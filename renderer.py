from math import sin, cos
from pathlib import Path
from pico2d import load_image
from config import FRAME_SIZE


class BoyRenderer:
    def __init__(self):
        assets = Path(__file__).parent / 'assets'
        self.idle_image = load_image(str(assets / 'animation_sheet.png'))
        self.run_image = load_image(str(assets / 'run_animation.png'))

    def draw(self, boy):
        if boy.state.name == 'SLEEP':
            row = 300 if boy.face_dir == 1 else 200
            side_extent = 16 if boy.face_dir == 1 else 14
            # Retain the prior lesson's opaque-sprite ground correction.
            ground_y = boy.y - 36
            draw_y = ground_y + 36 * cos(boy.sleep_angle) + side_extent * sin(boy.sleep_angle)
            self.idle_image.clip_composite_draw(
                0, row, FRAME_SIZE, FRAME_SIZE, -boy.face_dir * boy.sleep_angle,
                '', boy.x, draw_y, FRAME_SIZE, FRAME_SIZE)
        elif boy.state.name == 'IDLE':
            row = 300 if boy.face_dir == 1 else 200
            self.idle_image.clip_draw(int(boy.frame) * FRAME_SIZE, row,
                                      FRAME_SIZE, FRAME_SIZE, boy.x, boy.y)
        else:
            flip = '' if boy.face_dir == 1 else 'h'
            size = FRAME_SIZE * boy.scale
            draw_y = boy.y + 36 * (boy.scale - 1.0)
            self.run_image.clip_composite_draw(
                int(boy.frame) * FRAME_SIZE, 0, FRAME_SIZE, FRAME_SIZE,
                0, flip, boy.x, draw_y, size, size)
