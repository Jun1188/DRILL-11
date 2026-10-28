from pico2d import SDL_KEYDOWN, SDL_KEYUP, SDLK_LEFT, SDLK_RIGHT, SDLK_LSHIFT, SDLK_RSHIFT


class InputState:
    def __init__(self):
        self.left = False
        self.right = False
        self.shifts = set()

    @property
    def direction(self):
        return int(self.right) - int(self.left)

    def update(self, event):
        if event.type not in (SDL_KEYDOWN, SDL_KEYUP):
            return False
        pressed = event.type == SDL_KEYDOWN
        if event.key == SDLK_LEFT:
            self.left = pressed
        elif event.key == SDLK_RIGHT:
            self.right = pressed
        elif event.key in (SDLK_LSHIFT, SDLK_RSHIFT):
            if pressed:
                self.shifts.add(event.key)
            else:
                self.shifts.discard(event.key)
        else:
            return False
        return True

    def clear(self):
        self.left = self.right = False
        self.shifts.clear()

    def select_arrow(self, key):
        # A cancellation key takes precedence over stale held directions.
        self.left = key == SDLK_LEFT
        self.right = key == SDLK_RIGHT
