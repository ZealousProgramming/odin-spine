package main

import cc "core:c"
import "core:fmt"

import osc "odin_spine:core"
import osrl "odin_spine:impls/raylib"
import rl "vendor:raylib"

SCREEN_WIDTH := 1280
SCREEN_HEIGHT := 720

setup: #type proc()
update: #type proc(delta: f32)
draw: #type proc(delta: f32)
cleanup: #type proc()

main :: proc() {
	// --- Spineboy
	// setup = spineboy_setup
	// cleanup = spineboy_cleanup
	// update = spineboy_update
	// draw = spineboy_draw

	// --- Windmill
	// setup = windmill_setup
	// cleanup = windmill_cleanup
	// update = windmill_update
	// draw = windmill_draw

	// --- Coin
	// setup = coin_setup
	// cleanup = coin_cleanup
	// update = coin_update
	// draw = coin_draw

	// --- Dragon
	// setup = dragon_setup
	// cleanup = dragon_cleanup
	// update = dragon_update
	// draw = dragon_draw


	rl.InitWindow(
		cast(i32)SCREEN_WIDTH,
		cast(i32)SCREEN_HEIGHT,
		"odin-spine - EXAMPLES",
	)
	if setup != nil {
		setup()
	}

	defer if cleanup != nil {cleanup()}

	target := rl.Vector2{0.0, 0.0}

	camera := rl.Camera2D {
		rl.Vector2{cast(f32)SCREEN_WIDTH / 2.0, cast(f32)SCREEN_HEIGHT / 2.0},
		target,
		0.0,
		1.0,
	}

	camera.target = target
	camera.offset = rl.Vector2{0.0, 0.0}
	camera.rotation = 0.0
	camera.zoom = 1.0

	camera_speed: f32 = 800.0

	rl.SetTargetFPS(60)


	for !rl.WindowShouldClose() {
		delta := rl.GetFrameTime()

		// on_tick
		if rl.IsKeyDown(.RIGHT) {
			target.x += camera_speed * delta
		} else if rl.IsKeyDown(.LEFT) {
			target.x -= camera_speed * delta
		}

		if rl.IsKeyDown(.DOWN) {
			target.y += camera_speed * delta
		} else if rl.IsKeyDown(.UP) {
			target.y -= camera_speed * delta
		}

		camera.zoom += cast(cc.float)rl.GetMouseWheelMove() * 0.05

		if camera.zoom > 3.0 {
			camera.zoom = 3.0
		} else if camera.zoom < 0.1 {
			camera.zoom = 0.1
		}

		if rl.IsKeyPressed(.R) {
			camera.zoom = 1.0
			camera.rotation = 0.0
			target = rl.Vector2{0.0, 0.0}
		}

		camera.target = target

		if update != nil {
			update(delta)
		}

		// on_render
		rl.BeginDrawing()
		defer rl.EndDrawing()

		rl.BeginMode2D(camera)
		rl.ClearBackground(rl.GRAY)

		if draw != nil {
			draw(delta)
		}

		rl.EndMode2D()
		// rl.DrawText("Animation: " + osc.spAnimationState_getCurrent(animation_state, 0).animation.name, 10, 10)
		rl.DrawFPS(10, 10)

	}

	osrl.texture_2d_destroy()
	rl.CloseWindow()

}
