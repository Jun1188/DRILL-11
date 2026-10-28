class State:
    name = ''

    def enter(self, boy):
        boy.frame = 0.0

    def exit(self, boy):
        pass

    def handle_event(self, boy, event, movement_changed):
        pass

    def update(self, boy, dt):
        pass
