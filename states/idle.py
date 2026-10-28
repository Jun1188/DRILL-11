from pico2d import SDL_KEYDOWN, SDLK_a
from config import IDLE_FPS, IDLE_SLEEP_DELAY
from states.base import State


class Idle(State):
    name = 'IDLE'

    def enter(self, boy):
        super().enter(boy)
        boy.elapsed = 0.0
        boy.direction = 0

    def handle_event(self, boy, event, movement_changed):
        if event.type == SDL_KEYDOWN and event.key == SDLK_a:
            boy.change_state('AUTO_RUN')
        elif movement_changed:
            boy.select_manual_state()

    def update(self, boy, dt):
        boy.animate(IDLE_FPS, dt)
        boy.elapsed += dt
        if boy.elapsed >= IDLE_SLEEP_DELAY:
            boy.change_state('SLEEP')
