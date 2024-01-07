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
	cast(f32)SCREEN_HEIGHT - 200,
	0,
}

@(private = "file")
atlas: ^osc.spAtlas

dragon_setup :: proc() {
	atlas = osc.spAtlas_createFromFile(
		"./examples/assets/dragon/dragon-ess.atlas",
		nil,
	)

	json := osc.spSkeletonJson_create(atlas)
	defer osc.spSkeletonJson_dispose(json)

	skeleton_data := osc.spSkeletonJson_readSkeletonDataFile(
		json,
		"./examples/assets/dragon/json/dragon-ess.json",
	)

	if skeleton_data == nil {
		fmt.eprintf("%v\n", json.error)
		osc.spSkeletonJson_dispose(json)
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
		"flying",
		loop,
		delay,
	)

	osc.spAnimationState_update(animation_state, 0.0)
	osc.spAnimationState_apply(animation_state, skeleton)
	osc.spSkeleton_updateWorldTransform(skeleton)
}

dragon_cleanup :: proc() {
	osc.spSkeleton_dispose(skeleton)

	osc.spAtlas_dispose(atlas)
}


dragon_update :: proc(delta: f32) {


}

dragon_draw :: proc(delta: f32) {
	osc.spAnimationState_update(animation_state, delta)
	osc.spAnimationState_apply(animation_state, skeleton)
	osc.spSkeleton_updateWorldTransform(skeleton)
	osrl.draw_skeleton(skeleton, skeleton_position, false)

}
