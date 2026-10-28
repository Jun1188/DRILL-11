from config import CANVAS_WIDTH, FRAME_SIZE, FRAME_COUNT, START_X, STAND_Y
from input_state import InputState
from renderer import BoyRenderer
from states.idle import Idle
from states.walk import Walk
from states.run import Run
from states.sleep import Sleep
from states.auto_run import AutoRun


class Boy:
    def __init__(self):
        self.x, self.y = START_X, STAND_Y
        self.frame = 0.0
        self.elapsed = 0.0
        self.face_dir = 1
        self.direction = 0
        self.scale = 1.0
        self.sleep_angle = 0.0
        self.waking_up = False
        self.keys = InputState()
        self.renderer = BoyRenderer()
        self.states = {state.name: state for state in (Idle(), Walk(), Run(), Sleep(), AutoRun())}
        self.state = self.states['IDLE']
        self.state.enter(self)

    def change_state(self, name):
        if self.state.name == name:
            return
        self.state.exit(self)
        self.state = self.states[name]
        self.state.enter(self)

    def select_manual_state(self):
        self.direction = self.keys.direction
        if self.direction:
            self.face_dir = self.direction
        name = 'RUN' if self.direction and self.keys.shifts else 'WALK' if self.direction else 'IDLE'
        self.change_state(name)

    def animate(self, fps, dt):
        self.frame = (self.frame + fps * dt) % FRAME_COUNT

    def horizontal_bounds(self):
        half_width = FRAME_SIZE * self.scale / 2
        return half_width, CANVAS_WIDTH - half_width

    def move(self, speed, dt):
        left, right = self.horizontal_bounds()
        self.x = max(left, min(self.x + self.direction * speed * dt, right))

    def handle_event(self, event):
        movement_changed = self.keys.update(event)
        self.state.handle_event(self, event, movement_changed)

    def update(self, dt):
        self.state.update(self, max(0.0, dt))

    def draw(self):
        self.renderer.draw(self)
