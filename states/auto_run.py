from pico2d import SDL_KEYDOWN, SDLK_LEFT, SDLK_RIGHT
from config import AUTO_RUN_DURATION, AUTO_RUN_SCALE, AUTO_RUN_SPEED, AUTO_RUN_FPS
from states.base import State


class AutoRun(State):
    name = 'AUTO_RUN'

    def enter(self, boy):
        super().enter(boy)
        boy.elapsed = 0.0
        boy.scale = AUTO_RUN_SCALE
        boy.direction = boy.face_dir
        boy.keys.clear()
        left, right = boy.horizontal_bounds()
        boy.x = max(left, min(boy.x, right))

    def handle_event(self, boy, event, movement_changed):
        if event.type == SDL_KEYDOWN and event.key in (SDLK_LEFT, SDLK_RIGHT):
            boy.keys.select_arrow(event.key)
            boy.direction = boy.keys.direction
            boy.face_dir = boy.direction
            boy.change_state('RUN')

    def update(self, boy, dt):
        active_dt = min(dt, max(0.0, AUTO_RUN_DURATION - boy.elapsed))
        boy.animate(AUTO_RUN_FPS, active_dt)
        boy.move(AUTO_RUN_SPEED, active_dt)
        left, right = boy.horizontal_bounds()
        if boy.x <= left:
            boy.direction = 1
        elif boy.x >= right:
            boy.direction = -1
        boy.face_dir = boy.direction
        boy.elapsed += dt
        if boy.elapsed >= AUTO_RUN_DURATION:
            boy.keys.clear()
            boy.change_state('IDLE')

    def exit(self, boy):
        boy.scale = 1.0
