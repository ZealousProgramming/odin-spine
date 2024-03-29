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

coin_setup :: proc() {
	atlas = osc.spAtlas_createFromFile(
		"./examples/assets/coin/coin-proc.atlas",
		nil,
	)


	binary := osc.spSkeletonBinary_create(atlas)
	defer osc.spSkeletonBinary_dispose(binary)

	skeleton_data := osc.spSkeletonBinary_readSkeletonDataFile(
		binary,
		"./examples/assets/coin/binary/coin-pro.skel",
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
		"animation",
		loop,
		delay,
	)

	osc.spAnimationState_update(animation_state, 0.0)
	osc.spAnimationState_apply(animation_state, skeleton)
	osc.spSkeleton_updateWorldTransform(skeleton)
}

coin_cleanup :: proc() {
	osc.spSkeleton_dispose(skeleton)

	osc.spAtlas_dispose(atlas)
}


coin_update :: proc(delta: f32) {


}

coin_draw :: proc(delta: f32) {
	osc.spAnimationState_update(animation_state, delta)
	osc.spAnimationState_apply(animation_state, skeleton)
	osc.spSkeleton_updateWorldTransform(skeleton)
	osrl.draw_skeleton(skeleton, skeleton_position, false)

}
