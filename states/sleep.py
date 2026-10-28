from math import pi
from pico2d import SDL_KEYDOWN, SDLK_SPACE, SDLK_LEFT, SDLK_RIGHT
from config import SLEEP_TURN_DURATION
from states.base import State


class Sleep(State):
    name = 'SLEEP'

    def enter(self, boy):
        super().enter(boy)
        boy.direction = 0
        boy.keys.clear()
        boy.sleep_angle = 0.0
        boy.waking_up = False

    def handle_event(self, boy, event, movement_changed):
        if event.type != SDL_KEYDOWN:
            return
        if event.key == SDLK_SPACE:
            boy.waking_up = True
        elif event.key in (SDLK_LEFT, SDLK_RIGHT):
            boy.keys.select_arrow(event.key)
            boy.direction = boy.keys.direction
            boy.face_dir = boy.direction
            boy.change_state('WALK')

    def update(self, boy, dt):
        step = (pi / 2) * dt / SLEEP_TURN_DURATION
        if boy.waking_up:
            boy.sleep_angle = max(0.0, boy.sleep_angle - step)
            if boy.sleep_angle == 0.0:
                boy.change_state('IDLE')
        else:
            boy.sleep_angle = min(pi / 2, boy.sleep_angle + step)

    def exit(self, boy):
        boy.sleep_angle = 0.0
        boy.waking_up = False
