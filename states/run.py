from config import RUN_FPS, RUN_SPEED
from states.base import State


class Run(State):
    name = 'RUN'

    def handle_event(self, boy, event, movement_changed):
        if movement_changed:
            boy.select_manual_state()

    def update(self, boy, dt):
        boy.animate(RUN_FPS, dt)
        boy.move(RUN_SPEED, dt)
