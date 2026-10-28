from pico2d import (open_canvas, close_canvas, get_events, get_time,
                    clear_canvas, update_canvas, delay,
                    SDL_QUIT, SDL_KEYDOWN, SDLK_ESCAPE)
from config import CANVAS_WIDTH, CANVAS_HEIGHT
from boy import Boy
from grass import Grass


def main():
    open_canvas(CANVAS_WIDTH, CANVAS_HEIGHT)
    try:
        boy = Boy()
        grass = Grass()
        running = True
        last_time = get_time()
        while running:
            current_time = get_time()
            dt = current_time - last_time
            last_time = current_time
            for event in get_events():
                if event.type == SDL_QUIT or (event.type == SDL_KEYDOWN and event.key == SDLK_ESCAPE):
                    running = False
                    break
                boy.handle_event(event)
            if not running:
                break
            boy.update(dt)
            clear_canvas()
            grass.draw()
            boy.draw()
            update_canvas()
            delay(0.01)
    finally:
        close_canvas()


if __name__ == '__main__':
    main()
