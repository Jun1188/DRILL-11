from config import WALK_FPS, WALK_SPEED
from states.base import State


class Walk(State):
    name = 'WALK'

    def handle_event(self, boy, event, movement_changed):
        if movement_changed:
            boy.select_manual_state()

    def update(self, boy, dt):
        boy.animate(WALK_FPS, dt)
        boy.move(WALK_SPEED, dt)
