package main

import cc "core:c"
import "core:fmt"

import osc "odin_spine:core"
import osrl "odin_spine:impls/raylib"
import rl "vendor:raylib"

@(private = "file")
skeleton: ^osc.spSkeleton

@(private = "file")
animation_state: ^osc.spAnimationState
@(private = "file")
skeleton_position := rl.Vector3 {
	cast(f32)(SCREEN_WIDTH / 2),
	cast(f32)SCREEN_HEIGHT - 15,
	0,
}

@(private = "file")
atlas: ^osc.spAtlas

spineboy_setup :: proc() {
	atlas = osc.spAtlas_createFromFile(
		"./examples/assets/spineboy/spineboy-pro.atlas",
		nil,
	)

	// json := osc.spSkeletonJson_create(atlas)
	// defer osc.spSkeletonJson_dispose(json)

	// skeleton_data := osc.spSkeletonJson_readSkeletonDataFile(
	// 	json,
	// 	"assets/spineboy/json/spineboy-pro.json",
	// )

	// if skeleton_data == nil {
	// 	fmt.eprintf("%v\n", json.error)
	// 	osc.spSkeletonJson_dispose(json)
	// 	return
	// }

	binary := osc.spSkeletonBinary_create(atlas)
	defer osc.spSkeletonBinary_dispose(binary)

	skeleton_data := osc.spSkeletonBinary_readSkeletonDataFile(
		binary,
		"./examples/assets/spineboy/binary/spineboy-pro.skel",
	)

	if skeleton_data == nil {
		// fmt.eprintf("%v\n", json.error)
		osc.spSkeletonBinary_dispose(binary)
		return
	}

	osc.spBone_setYDown(true)
	skeleton = osc.spSkeleton_create(skeleton_data)

	skeleton.scaleX = 0.5
	skeleton.scaleY = 0.5


	// Create the spAnimationStateData
	animation_state_data := osc.spAnimationStateData_create(skeleton_data)
	animation_state = osc.spAnimationState_create(animation_state_data)
	// Add the animation "walk" to track 0, without delay, and let it loop indefinitely
	track: cc.int = 0
	loop: cc.bool = true
	delay: cc.float = 0

	osc.spAnimationState_addAnimationByName(
		animation_state,
		track,
		"idle",
		loop,
		delay,
	)

	osc.spAnimationState_addAnimationByName(
		animation_state,
		track,
		"walk",
		loop,
		delay,
	)

	osc.spAnimationState_addAnimationByName(
		animation_state,
		track,
		"run",
		loop,
		delay,
	)

	osc.spAnimationState_addAnimationByName(
		animation_state,
		track,
		"jump",
		loop,
		delay,
	)

	osc.spAnimationState_addAnimationByName(
		animation_state,
		track,
		"hoverboard",
		loop,
		delay,
	)

	osc.spAnimationState_setAnimationByName(animation_state, 0, "idle", true)

	osc.spAnimationState_update(animation_state, 0.0)
	osc.spAnimationState_apply(animation_state, skeleton)
	osc.spSkeleton_updateWorldTransform(skeleton)
}

spineboy_cleanup :: proc() {
	osc.spSkeleton_dispose(skeleton)

	osc.spAtlas_dispose(atlas)
}


spineboy_update :: proc(delta: f32) {
	if rl.IsKeyPressed(rl.KeyboardKey.ONE) {
		osc.spAnimationState_setAnimationByName(
			animation_state,
			0,
			"idle",
			true,
		)
	}

	if rl.IsKeyPressed(rl.KeyboardKey.TWO) {
		osc.spAnimationState_setAnimationByName(
			animation_state,
			0,
			"walk",
			true,
		)
	}

	if rl.IsKeyPressed(rl.KeyboardKey.THREE) {
		osc.spAnimationState_setAnimationByName(
			animation_state,
			0,
			"run",
			true,
		)
	}

	if rl.IsKeyPressed(rl.KeyboardKey.FOUR) {
		osc.spAnimationState_setAnimationByName(
			animation_state,
			0,
			"jump",
			true,
		)
	}

	if rl.IsKeyPressed(rl.KeyboardKey.FIVE) {
		osc.spAnimationState_setAnimationByName(
			animation_state,
			0,
			"hoverboard",
			true,
		)
	}

}

spineboy_draw :: proc(delta: f32) {
	osc.spAnimationState_update(animation_state, delta)
	osc.spAnimationState_apply(animation_state, skeleton)
	osc.spSkeleton_updateWorldTransform(skeleton)
	osrl.draw_skeleton(skeleton, skeleton_position, false)

}
