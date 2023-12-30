/******************************************************************************
 * Spine Runtimes License Agreement
 * Last updated July 28, 2023. Replaces all prior versions.
 *
 * Copyright (c) 2013-2023, Esoteric Software LLC
 *
 * Integration of the Spine Runtimes into software or otherwise creating
 * derivative works of the Spine Runtimes is permitted under the terms and
 * conditions of Section 2 of the Spine Editor License Agreement:
 * http://esotericsoftware.com/spine-editor-license
 *
 * Otherwise, it is permitted to integrate the Spine Runtimes into software or
 * otherwise create derivative works of the Spine Runtimes (collectively,
 * "Products"), provided that each user of the Products must obtain their own
 * Spine Editor license and redistribution of the Products in any form must
 * include this license and copyright notice.
 *
 * THE SPINE RUNTIMES ARE PROVIDED BY ESOTERIC SOFTWARE LLC "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL ESOTERIC SOFTWARE LLC BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES,
 * BUSINESS INTERRUPTION, OR LOSS OF USE, DATA, OR PROFITS) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THE
 * SPINE RUNTIMES, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *****************************************************************************/

package core

import cc "core:c"
import lc "core:c/libc"
import "core:fmt"


#assert(size_of(rune) == size_of(cc.int))

// - C Imports -
// --------------------------------------
when ODIN_OS == .Windows {
	@(extra_linker_flags = "/NODEFAULTLIB:msvcrtd")
	foreign import lib {"../lib/windows/spine-c.lib", "system:ucrt.lib"}
}

// - Constants -
// --------------------------------------
SPINE_MAJOR_VERSION :: 4
SPINE_MINOR_VERSION :: 1
SPINE_VERSION_STRING :: "4.1"


// Found in *.h
SP_MAX_PROPERTY_IDS :: 3
SP_SEQUENCE_MODE_HOLD :: 0
SP_SEQUENCE_MODE_ONCE :: 1
SP_SEQUENCE_MODE_LOOP :: 2
SP_SEQUENCE_MODE_PINGPONG :: 3
SP_SEQUENCE_MODE_ONCEREVERSE :: 4
SP_SEQUENCE_MODE_LOOPREVERSE :: 5
SP_SEQUENCE_MODE_PINGPONGREVERSE :: 6
SKIN_ENTRIES_HASH_TABLE_SIZE :: 100

// Found in *.c
CURVE1_ENTRIES :: 2
CURVE1_VALUE :: 1
CURVE2_ENTRIES :: 3
CURVE2_VALUE1 :: 1
CURVE2_VALUE2 :: 2
RGB_ENTRIES :: 4
SUBSEQUENT :: 0
FIRST :: 1
HOLD_SUBSEQUENT :: 2
HOLD_FIRST :: 3
HOLD_MIX :: 4
SETUP :: 1
CURRENT :: 2
PATHCONSTRAINT_NONE :: -1
PATHCONSTRAINT_BEFORE :: -2
PATHCONSTRAINT_AFTER :: -3
EPSILON :: 0.00001
ATTACHMENT_REGION :: 0
ATTACHMENT_BOUNDING_BOX :: 1
ATTACHMENT_MESH :: 2
ATTACHMENT_LINKED_MESH :: 3
ATTACHMENT_PATH :: 4
BLEND_MODE_NORMAL :: 0
BLEND_MODE_ADDITIVE :: 1
BLEND_MODE_MULTIPLY :: 2
BLEND_MODE_SCREEN :: 3
BONE_ROTATE :: 0
BONE_TRANSLATE :: 1
BONE_TRANSLATEX :: 2
BONE_TRANSLATEY :: 3
BONE_SCALE :: 4
BONE_SCALEX :: 5
BONE_SCALEY :: 6
BONE_SHEAR :: 7
BONE_SHEARX :: 8
BONE_SHEARY :: 9
SLOT_ATTACHMENT :: 0
SLOT_RGBA :: 1
SLOT_RGB :: 2
SLOT_RGBA2 :: 3
SLOT_RGB2 :: 4
SLOT_ALPHA :: 5
ATTACHMENT_DEFORM :: 0
ATTACHMENT_SEQUENCE :: 1
PATH_POSITION :: 0
PATH_SPACING :: 1
PATH_MIX :: 2
CURVE_LINEAR :: 0
CURVE_STEPPED :: 1
CURVE_BEZIER :: 2
BEZIER_SIZE :: 18
PATH_POSITION_FIXED :: 0
PATH_POSITION_PERCENT :: 1
PATH_SPACING_LENGTH :: 0
PATH_SPACING_FIXED :: 1
PATH_SPACING_PERCENT :: 2
PATH_ROTATE_TANGENT :: 0
PATH_ROTATE_CHAIN :: 1
PATH_ROTATE_CHAIN_SCALE :: 2

// - Enum -
// --------------------------------------
spMixBlend :: enum cc.int {
	SP_MIX_BLEND_SETUP = 0,
	SP_MIX_BLEND_FIRST,
	SP_MIX_BLEND_REPLACE,
	SP_MIX_BLEND_ADD,
}

spMixDirection :: enum cc.int {
	SP_MIX_DIRECTION_IN = 0,
	SP_MIX_DIRECTION_OUT,
}

spTimelineType :: enum cc.int {
	SP_TIMELINE_ATTACHMENT = 0,
	SP_TIMELINE_ALPHA,
	SP_TIMELINE_PATHCONSTRAINTPOSITION,
	SP_TIMELINE_PATHCONSTRAINTSPACING,
	SP_TIMELINE_ROTATE,
	SP_TIMELINE_SCALEX,
	SP_TIMELINE_SCALEY,
	SP_TIMELINE_SHEARX,
	SP_TIMELINE_SHEARY,
	SP_TIMELINE_TRANSLATEX,
	SP_TIMELINE_TRANSLATEY,
	SP_TIMELINE_SCALE,
	SP_TIMELINE_SHEAR,
	SP_TIMELINE_TRANSLATE,
	SP_TIMELINE_DEFORM,
	SP_TIMELINE_SEQUENCE,
	SP_TIMELINE_IKCONSTRAINT,
	SP_TIMELINE_PATHCONSTRAINTMIX,
	SP_TIMELINE_RGB2,
	SP_TIMELINE_RGBA2,
	SP_TIMELINE_RGBA,
	SP_TIMELINE_RGB,
	SP_TIMELINE_TRANSFORMCONSTRAINT,
	SP_TIMELINE_DRAWORDER,
	SP_TIMELINE_EVENT,
}

spProperty :: enum cc.int {
	SP_PROPERTY_ROTATE                  = 1 << 0,
	SP_PROPERTY_X                       = 1 << 1,
	SP_PROPERTY_Y                       = 1 << 2,
	SP_PROPERTY_SCALEX                  = 1 << 3,
	SP_PROPERTY_SCALEY                  = 1 << 4,
	SP_PROPERTY_SHEARX                  = 1 << 5,
	SP_PROPERTY_SHEARY                  = 1 << 6,
	SP_PROPERTY_RGB                     = 1 << 7,
	SP_PROPERTY_ALPHA                   = 1 << 8,
	SP_PROPERTY_RGB2                    = 1 << 9,
	SP_PROPERTY_ATTACHMENT              = 1 << 10,
	SP_PROPERTY_DEFORM                  = 1 << 11,
	SP_PROPERTY_EVENT                   = 1 << 12,
	SP_PROPERTY_DRAWORDER               = 1 << 13,
	SP_PROPERTY_IKCONSTRAINT            = 1 << 14,
	SP_PROPERTY_TRANSFORMCONSTRAINT     = 1 << 15,
	SP_PROPERTY_PATHCONSTRAINT_POSITION = 1 << 16,
	SP_PROPERTY_PATHCONSTRAINT_SPACING  = 1 << 17,
	SP_PROPERTY_PATHCONSTRAINT_MIX      = 1 << 18,
	SP_PROPERTY_SEQUENCE                = 1 << 19,
}

spEventType :: enum cc.int {
	SP_ANIMATION_START = 0,
	SP_ANIMATION_INTERRUPT,
	SP_ANIMATION_END,
	SP_ANIMATION_COMPLETE,
	SP_ANIMATION_DISPOSE,
	SP_ANIMATION_EVENT,
}

spAtlasFormat :: enum cc.int {
	SP_ATLAS_UNKNOWN_FORMAT = 0,
	SP_ATLAS_ALPHA,
	SP_ATLAS_INTENSITY,
	SP_ATLAS_LUMINANCE_ALPHA,
	SP_ATLAS_RGB565,
	SP_ATLAS_RGBA4444,
	SP_ATLAS_RGB888,
	SP_ATLAS_RGBA8888,
}

spAtlasFilter :: enum cc.int {
	SP_ATLAS_UNKNOWN_FILTER = 0,
	SP_ATLAS_NEAREST,
	SP_ATLAS_LINEAR,
	SP_ATLAS_MIPMAP,
	SP_ATLAS_MIPMAP_NEAREST_NEAREST,
	SP_ATLAS_MIPMAP_LINEAR_NEAREST,
	SP_ATLAS_MIPMAP_NEAREST_LINEAR,
	SP_ATLAS_MIPMAP_LINEAR_LINEAR,
}

spAtlasWrap :: enum cc.int {
	SP_ATLAS_MIRROREDREPEAT = 0,
	SP_ATLAS_CLAMPTOEDGE,
	SP_ATLAS_REPEAT,
}

spAttachmentType :: enum cc.int {
	SP_ATTACHMENT_REGION = 0,
	SP_ATTACHMENT_BOUNDING_BOX,
	SP_ATTACHMENT_MESH,
	SP_ATTACHMENT_LINKED_MESH,
	SP_ATTACHMENT_PATH,
	SP_ATTACHMENT_POINT,
	SP_ATTACHMENT_CLIPPING,
}

spTransformMode :: enum cc.int {
	SP_TRANSFORMMODE_NORMAL = 0,
	SP_TRANSFORMMODE_ONLYTRANSLATION,
	SP_TRANSFORMMODE_NOROTATIONORREFLECTION,
	SP_TRANSFORMMODE_NOSCALE,
	SP_TRANSFORMMODE_NOSCALEORREFLECTION,
}

spPositionMode :: enum cc.int {
	SP_POSITION_MODE_FIXED = 0,
	SP_POSITION_MODE_PERCENT,
}

spSpacingMode :: enum cc.int {
	SP_SPACING_MODE_LENGTH = 0,
	SP_SPACING_MODE_FIXED,
	SP_SPACING_MODE_PERCENT,
	SP_SPACING_MODE_PROPORTIONAL,
}

spRotateMode :: enum cc.int {
	SP_ROTATE_MODE_TANGENT = 0,
	SP_ROTATE_MODE_CHAIN,
	SP_ROTATE_MODE_CHAIN_SCALE,
}

spBlendMode :: enum cc.int {
	SP_BLEND_MODE_NORMAL = 0,
	SP_BLEND_MODE_ADDITIVE,
	SP_BLEND_MODE_MULTIPLY,
	SP_BLEND_MODE_SCREEN,
}


// - Structs -
// --------------------------------------

spAnimation :: struct {
	name:        cstring,
	duration:    cc.float,
	timelines:   ^spTimelineArray,
	timelineIds: ^spPropertyIdArray,
}

spAnimationState :: struct {
	data:           ^spAnimationStateData,
	tracksCount:    cc.int,
	tracks:         [^]^spTrackEntry,
	listener:       #type proc(
		state: ^spAnimationState,
		type: spEventType,
		entry: ^spTrackEntry,
		event: ^spEvent,
	),
	timeScale:      cc.float,
	rendererObject: rawptr,
	userData:       rawptr,
	unkeyedState:   cc.int,
}

spAnimationStateData :: struct {
	skeletonData: ^spSkeletonData,
	defaultMix:   cc.float,
	entries:      rawptr,
}

spAlphaTimeline :: struct {
	super:     spCurveTimeline1,
	slotIndex: cc.int,
}

spAtlas :: struct {
	pages:          [^]spAtlasPage,
	regions:        [^]spAtlasRegion,
	rendererObject: rawptr,
}


spAtlasPage :: struct {
	atlas:                ^spAtlas,
	name:                 cstring,
	format:               spAtlasFormat,
	minFilter, magFilter: spAtlasFilter,
	uWrap, vWrap:         spAtlasWrap,
	rendererObject:       rawptr,
	width, height:        cc.int,
	pma:                  cc.bool,
	next:                 ^spAtlasPage,
}

spAtlasRegion :: struct {
	super:     spTextureRegion,
	name:      cstring,
	x, y:      cc.int,
	index:     cc.int,
	splits:    [^]cc.int,
	pads:      [^]cc.int,

	// TODO(devon): CHECK ON if ^spKeyValueArray or [^]spKeyValueArray
	keyValues: ^spKeyValueArray,
	page:      ^spAtlasPage,
	next:      ^spAtlasRegion,
}

spAtlasAttachmentLoader :: struct {
	super: spAttachmentLoader,
	atlas: ^spAtlas,
}

spAttachment :: struct {
	name:             cstring,
	type:             spAttachmentType,
	vtable:           rawptr,
	refCount:         cc.int,
	attachmentLoader: ^spAttachmentLoader,
}

spAttachmentLoader :: struct {
	error1: cstring,
	error2: cstring,
	vtable: rawptr,
}

spAttachmentTimeline :: struct {
	super:           spTimeline,
	slotIndex:       cc.int,
	attachmentNames: [^]cstring,
}

spBone :: struct {
	data:                             ^spBoneData,
	skeleton:                         ^spSkeleton,
	parent:                           ^spBone,
	childrenCount:                    cc.int,
	children:                         [^]^spBone,
	x, y, ax, ay:                     cc.float,
	rotation, arotation:              cc.float,
	scaleX, scaleY, ascaleX, ascaleY: cc.float,
	shearX, shearY, ashearX, ashearY: cc.float,
	a, b, c, d:                       cc.float,
	worldX, worldY:                   cc.float,
	sorted:                           cc.bool,
	active:                           cc.bool,
}

spBoneData :: struct {
	index:          cc.int,
	name:           cstring,
	parent:         ^spBoneData,
	length:         cc.float,
	x, y:           cc.float,
	rotation:       cc.float,
	scaleX, scaleY: cc.float,
	shearX, shearY: cc.float,
	transformMode:  spTransformMode,
	skinRequired:   cc.bool,
	color:          spColor,
}


spBoundingBoxAttachment :: struct {
	super: spVertexAttachment,
	color: spColor,
}

spClippingAttachment :: struct {
	super:   spVertexAttachment,
	endSlot: ^spSlotData,
	color:   spColor,
}

// TODO(devon): Can we change this to a distinct [4]cc.float for swizzles?
spColor :: struct {
	r: cc.float,
	g: cc.float,
	b: cc.float,
	a: cc.float,
}

spCurveTimeline :: struct {
	super:  spTimeline,
	curves: ^spFloatArray,
}


spCurveTimeline1 :: spCurveTimeline
spCurveTimeline2 :: spCurveTimeline

spDeformTimeline :: struct {
	super:              spCurveTimeline,
	frameVerticesCount: cc.int,
	frameVertices:      [^][^]cc.float,
	slotIndex:          cc.int,
	attachment:         ^spAttachment,
}

spDrawOrderTimeline :: struct {
	super:      spTimeline,
	drawOrders: [^][^]cc.int,
	slotsCount: cc.int,
}

spEventData :: struct {
	name:        cstring,
	intValue:    cc.int,
	floatValue:  cc.float,
	stringValue: cstring,
	audioPath:   cstring,
	volume:      cc.float,
	balance:     cc.float,
}

spEvent :: struct {
	data:        ^spEventData,
	time:        cc.float,
	intValue:    cc.int,
	floatValue:  cc.float,
	stringValue: cstring,
	volume:      cc.float,
	balance:     cc.float,
}

spEventTimeline :: struct {
	super:  spTimeline,
	events: [^]^spEvent,
}

spIkConstraint :: struct {
	data:          ^spIkConstraintData,
	bonesCount:    cc.int,
	bones:         [^]^spBone,
	target:        ^spBone,
	bendDirection: cc.int,
	compress:      cc.bool,
	stretch:       cc.bool,
	mix:           cc.float,
	softness:      cc.float,
	active:        cc.bool,
}

spIkConstraintData :: struct {
	name:          cstring,
	order:         cc.int,
	skinRequired:  cc.bool,
	bonesCount:    cc.int,
	bones:         [^]^spBoneData,
	target:        ^spBoneData,
	bendDirection: cc.int,
	compress:      cc.bool,
	stretch:       cc.bool,
	uniform:       cc.bool,
	mix:           cc.float,
	softness:      cc.float,
}

spIkConstraintTimeline :: struct {
	super:             spCurveTimeline,
	ikConstraintIndex: cc.int,
}

spKeyValue :: struct {
	name:   cstring,
	values: [5]cc.float,
}

spMeshAttachment :: struct {
	super:          spVertexAttachment,
	rendererObject: rawptr,
	region:         ^spTextureRegion,
	sequence:       ^spSequence,
	path:           cstring,
	regionUVs:      [^]cc.float,
	uvs:            [^]cc.float,
	trianglesCount: cc.int,
	triangles:      cc.ushort,
	color:          spColor,
	hullLength:     cc.int,
	parentMesh:     ^spMeshAttachment,
	edgesCount:     cc.int,
	edges:          [^]cc.int,
	width, height:  cc.float,
}

spPathAttachment :: struct {
	super:         spVertexAttachment,
	lengthsLength: cc.int,
	lengths:       [^]cc.float,
	closed:        cc.bool,
	constantSpeed: cc.bool,
	color:         spColor,
}

spPathConstraint :: struct {
	data:           ^spPathConstraintData,
	bonesCount:     cc.int,
	bones:          [^]^spBone,
	target:         ^spSlot,
	position:       cc.float,
	spacing:        cc.float,
	mixRotate:      cc.float,
	mixX, mixY:     cc.float,
	spacesCount:    cc.int,
	spaces:         [^]cc.float,
	positionsCount: cc.int,
	positions:      [^]cc.float,
	worldCount:     cc.int,
	world:          [^]cc.float,
	curvesCount:    cc.int,
	curves:         [^]cc.float,
	lengthsCount:   cc.int,
	lengths:        [^]cc.float,
	segments:       [10]cc.float,
	active:         cc.bool,
}

spPathConstraintData :: struct {
	name:           cstring,
	order:          cc.int,
	skinRequired:   cc.bool,
	bonesCount:     cc.int,
	bones:          [^]^spBoneData,
	target:         ^spSlotData,
	positionMode:   spPositionMode,
	spacingMode:    spSpacingMode,
	rotateMode:     spRotateMode,
	offsetRotation: cc.float,
	position:       cc.float,
	spacing:        cc.float,
	mixRotate:      cc.float,
	mixX, mixY:     cc.float,
}

spPathConstraintMixTimeline :: struct {
	super:               spCurveTimeline,
	pathConstraintIndex: cc.int,
}

spPathConstraintPositionTimeline :: struct {
	super:               spCurveTimeline,
	pathConstraintIndex: cc.int,
}

spPathConstraintSpacingTimeline :: struct {
	super:               spCurveTimeline,
	pathConstraintIndex: cc.int,
}

spPointAttachment :: struct {
	super:    spAttachment,
	x, y:     cc.float,
	rotation: cc.float,
	color:    spColor,
}

spPolygon :: struct {
	vertices: [^]cc.float,
	count:    cc.int,
	capacity: cc.int,
}

spPropertyId :: cc.uint64_t

spRegionAttachment :: struct {
	super:          spAttachment,
	path:           cstring,
	x, y:           cc.float,
	scaleX, scaleY: cc.float,
	rotation:       cc.float,
	width, height:  cc.float,
	color:          spColor,
	rendererObject: rawptr,
	region:         ^spTextureRegion,
	sequence:       ^spSequence,
	offset:         [8]cc.float,
	uvs:            [8]cc.float,
}

spRGBATimeline :: struct {
	super:     spCurveTimeline2,
	slotIndex: cc.int,
}

spRGBA2Timeline :: struct {
	super:     spCurveTimeline,
	slotIndex: cc.int,
}

spRGBTimeline :: struct {
	super:     spCurveTimeline2,
	slotIndex: cc.int,
}

spRGB2Timeline :: struct {
	super:     spCurveTimeline,
	slotIndex: cc.int,
}

spRotateTimeline :: struct {
	super:     spCurveTimeline1,
	boneIndex: cc.int,
}

spScaleTimeline :: struct {
	super:     spCurveTimeline2,
	boneIndex: cc.int,
}

spScaleXTimeline :: struct {
	super:     spCurveTimeline1,
	boneIndex: cc.int,
}

spScaleYTimeline :: struct {
	super:     spCurveTimeline1,
	boneIndex: cc.int,
}

spSequence :: struct {
	id:         cc.int,
	start:      cc.int,
	digits:     cc.int,
	setupIndex: cc.int,
	regions:    ^spTextureRegionArray,
}

spSequenceTimeline :: struct {
	super:      spTimeline,
	slotIndex:  cc.int,
	attachment: ^spAttachment,
}

spShearTimeline :: struct {
	super:     spCurveTimeline2,
	boneIndex: cc.int,
}

spShearXTimeline :: struct {
	super:     spCurveTimeline1,
	boneIndex: cc.int,
}

spShearYTimeline :: struct {
	super:     spCurveTimeline1,
	boneIndex: cc.int,
}

spSkeleton :: struct {
	data:                      ^spSkeletonData,
	bonesCount:                cc.int,
	bones:                     [^]^spBone,
	root:                      ^spBone,
	slotsCount:                cc.int,
	slots:                     [^]^spSlot,
	drawOrder:                 [^]^spSlot,
	ikConstraintsCount:        cc.int,
	ikConstraints:             [^]^spIkConstraint,
	transformConstraintsCount: cc.int,
	transformConstraints:      [^]^spTransformConstraint,
	pathConstraintsCount:      cc.int,
	pathConstraints:           [^]^spPathConstraint,
	skin:                      ^spSkin,
	color:                     spColor,
	scaleX, scaleY:            cc.float,
	x, y:                      cc.float,
}

spSkeletonBinary :: struct {
	scale:            cc.float,
	attachmentLoader: ^spAttachmentLoader,
	error:            cstring,
}

spSkeletonBounds :: struct {
	count:         cc.int,
	boundingBoxes: [^]^spBoundingBoxAttachment,
	polygons:      [^]^spPolygon,
	minX, minY:    cc.float,
	maxX, maxY:    cc.float,
}

spSkeletonClipping :: struct {
	triangulator:     ^spTriangulator,
	clippingPolygon:  ^spFloatArray,
	clipOutput:       ^spFloatArray,
	clippedVertices:  ^spFloatArray,
	clippedUVs:       ^spFloatArray,
	clippedTriangles: ^spUnsignedShortArray,
	scratch:          ^spFloatArray,
	clipAttachment:   ^spClippingAttachment,
	clippingPolygons: ^spArrayFloatArray,
}

spSkeletonData :: struct {
	version:                   cstring,
	hash:                      cstring,
	x, y:                      cc.float,
	width, height:             cc.float,
	fps:                       cc.float,
	imagesPath:                cstring,
	audioPath:                 cstring,
	stringsCount:              cc.int,
	strings:                   [^]cstring,
	bonesCount:                cc.int,
	bones:                     [^]^spBoneData,
	slotsCount:                cc.int,
	slots:                     [^]^spSlotData,
	skinsCount:                cc.int,
	skins:                     [^]^spSkin,
	defaultSkin:               ^spSkin,
	eventsCount:               cc.int,
	events:                    [^]^spEventData,
	animationsCount:           cc.int,
	animations:                [^]^spAnimation,
	ikConstraintsCount:        cc.int,
	ikConstraints:             [^]^spIkConstraintData,
	transformConstraintsCount: cc.int,
	transformConstraints:      [^]^spTransformConstraintData,
	pathConstraintsCount:      cc.int,
	pathConstraints:           [^]^spPathConstraintData,
}

spSkeletonJson :: struct {
	scale:            cc.float,
	attachmentLoader: ^spAttachmentLoader,
	error:            cstring,
}

spSkin :: struct {
	name:                 cstring,
	bones:                ^spBoneDataArray,
	ikConstraints:        ^spIkConstraintDataArray,
	transformConstraints: ^spTransformConstraintDataArray,
	pathConstraints:      ^spPathConstraintDataArray,
}

spSkinEntry :: struct {
	slotIndex:  cc.int,
	name:       cstring,
	attachment: ^spAttachment,
	next:       ^spSkinEntry,
}

spSlot :: struct {
	data:            ^spSlotData,
	bone:            ^spBone,
	color:           spColor,
	darkColor:       ^spColor,
	attachment:      ^spAttachment,
	attachmentState: cc.int,
	deformCapacity:  cc.int,
	deformCount:     cc.int,
	deform:          [^]cc.float,
	sequenceIndex:   cc.int,
}

spSlotData :: struct {
	index:          cc.int,
	name:           cstring,
	boneData:       ^spBoneData,
	attachmentName: cstring,
	color:          spColor,
	darkcolor:      ^spColor,
	blendMode:      spBlendMode,
}

spTextureRegion :: struct {
	rendererObject:                rawptr,
	u, v:                          cc.float,
	u2, v2:                        cc.float,
	degrees:                       cc.int,
	offsetX, ossetY:               cc.float,
	width, height:                 cc.int,
	originalWidth, originalHeight: cc.int,
}

_spTimelineVtable :: struct {
	apply:     #type proc(
		self: ^spTimeline,
		skeleton: ^spSkeleton,
		lastTime: cc.float,
		time: cc.float,
		firedEvents: [^]^spEvent,
		eventsCount: [^]cc.int,
		alpha: cc.float,
		blend: spMixBlend,
		direction: spMixDirection,
	),
	dispose:   #type proc(self: ^spTimeline),
	setBezier: #type proc(
		self: ^spTimeline,
		bezier: cc.int,
		frame: cc.int,
		value: cc.float,
		time1: cc.float,
		value1: cc.float,
		cx1: cc.float,
		cy1: cc.float,
		cx2: cc.float,
		cy2: cc.float,
		time2: cc.float,
		value2: cc.float,
	),
}

spTimeline :: struct {
	vtable:           _spTimelineVtable,
	propertyIds:      [SP_MAX_PROPERTY_IDS]spPropertyId,
	propertyIdsCount: cc.int,
	frames:           ^spFloatArray,
	frameCount:       cc.int,
	frameEntries:     cc.int,
	type:             spTimelineType,
}

spTrackEntry :: struct {
	animation:                                                      ^spAnimation,
	previous:                                                       ^spTrackEntry,
	next:                                                           ^spTrackEntry,
	mixingFrom:                                                     ^spTrackEntry,
	mixingTo:                                                       ^spTrackEntry,
	listener:                                                       #type proc(
		state: ^spAnimationState,
		type: spEventType,
		entry: ^spTrackEntry,
		event: ^spEvent,
	),
	trackIndex:                                                     cc.bool,
	loop:                                                           cc.bool,
	holdPrevious:                                                   cc.bool,
	reverse:                                                        cc.bool,
	shortestRotation:                                               cc.bool,
	eventThreshold, attachmentThreshold, drawOrderThreshold:        cc.float,
	animationStart, animationEnd, animationLast, nextAnimationLast: cc.float,
	delay:                                                          cc.float,
	trackTime, trackLast, nextTrackLast, trackEnd:                  cc.float,
	timeScale:                                                      cc.float,
	alpha:                                                          cc.float,
	mixTime, mixDuration:                                           cc.float,
	interruptAlpha, totalAlpha:                                     cc.float,
	mixBlend:                                                       spMixBlend,
	timelineMode:                                                   ^spIntArray,
	timelineHoldMix:                                                ^spTrackEntryArray,
	timelinesRotation:                                              [^]cc.float,
	timelinesRotationCount:                                         cc.int,
	rendererObject:                                                 rawptr,
	userData:                                                       rawptr,
}

spTransformConstraint :: struct {
	data:                 ^spTransformConstraintData,
	bonesCount:           cc.int,
	bones:                [^]^spBone,
	target:               ^spBone,
	mixRotate:            cc.float,
	mixX, mixY:           cc.float,
	mixScaleX, mixScaleY: cc.float,
	mixShearY:            cc.float,
	active:               cc.bool,
}

spTransformConstraintData :: struct {
	name:                       cstring,
	order:                      cc.int,
	skinRequired:               cc.bool,
	bonesCount:                 cc.int,
	bones:                      [^]^spBoneData,
	target:                     ^spBoneData,
	mixRotate:                  cc.float,
	minX, minY:                 cc.float,
	minScaleX, minScaleY:       cc.float,
	mixShearY:                  cc.float,
	offsetRotation:             cc.float,
	offsetX, offsetY:           cc.float,
	offsetScaleX, offsetScaleY: cc.float,
	offsetShearY:               cc.float,
	relative:                   cc.bool,
	local:                      cc.bool,
}

spTransformConstraintTimeline :: struct {
	super:                    spCurveTimeline,
	transformConstraintIndex: cc.int,
}

spTranslateTimeline :: struct {
	super:     spCurveTimeline2,
	boneIndex: cc.int,
}

spTranslateXTimeline :: struct {
	super:     spCurveTimeline1,
	boneIndex: cc.int,
}

spTranslateYTimeline :: struct {
	super:     spCurveTimeline1,
	boneIndex: cc.int,
}

spTriangulator :: struct {
	convexPolygons:        ^spArrayFloatArray,
	convexPolygonsIndices: ^spArrayShortArray,
	indicesArray:          ^spShortArray,
	isConcaveArray:        ^spIntArray,
	triangles:             ^spShortArray,
	polygonPool:           ^spArrayFloatArray,
	polygonIndicesPool:    ^spArrayShortArray,
}

spVertexAttachment :: struct {
	super:               spAttachment,
	bonesCount:          cc.int,
	bones:               [^]cc.int,
	verticesCount:       cc.int,
	vertices:            [^]cc.float,
	worldVerticesLength: cc.int,
	timelineAttachment:  ^spAttachment,
	id:                  cc.int,
}

// Arrays
spFloatArray :: struct {
	size:     cc.int,
	capacity: cc.int,
	items:    [^]cc.float,
}

spIntArray :: struct {
	size:     cc.int,
	capacity: cc.int,
	items:    [^]cc.int,
}

spShortArray :: struct {
	size:     cc.int,
	capacity: cc.int,
	items:    [^]cc.short,
}

spUnsignedShortArray :: struct {
	size:     cc.int,
	capacity: cc.int,
	items:    [^]cc.ushort,
}

spArrayFloatArray :: struct {
	size:     cc.int,
	capacity: cc.int,
	items:    [^]^spFloatArray,
}

spArrayShortArray :: struct {
	size:     cc.int,
	capacity: cc.int,
	items:    [^]^spShortArray,
}

spBoneDataArray :: struct {
	size:     cc.int,
	capacity: cc.int,
	items:    [^]^spBoneData,
}

spIkConstraintDataArray :: struct {
	size:     cc.int,
	capacity: cc.int,
	items:    [^]^spIkConstraintData,
}

spTransformConstraintDataArray :: struct {
	size:     cc.int,
	capacity: cc.int,
	items:    [^]^spTransformConstraintData,
}

spPathConstraintDataArray :: struct {
	size:     cc.int,
	capacity: cc.int,
	items:    [^]^spPathConstraintData,
}

spTextureRegionArray :: struct {
	size:     cc.int,
	capacity: cc.int,
	items:    [^]^spTextureRegion,
}

spKeyValueArray :: struct {
	size:     cc.int,
	capacity: cc.int,
	items:    [^]spKeyValue,
}

spTrackEntryArray :: struct {
	size:     cc.int,
	capacity: cc.int,
	items:    [^]^spTrackEntry,
}

spPropertyIdArray :: struct {
	size:     cc.int,
	capacity: cc.int,
	items:    [^]spPropertyId,
}

spTimelineArray :: struct {
	size:     cc.int,
	capacity: cc.int,
	items:    [^]^spTimeline,
}


// - Procedures -
// --------------------------------------


@(default_calling_convention = "c")
foreign lib {
	// [Animation.h] ---
	SP_API spAnimation *spAnimation_create(const char *name, spTimelineArray *timelines, float duration);
	SP_API void spAnimation_dispose(spAnimation *self);
	SP_API int /*bool*/ spAnimation_hasTimeline(spAnimation *self, spPropertyId *ids, int idsCount);
	/** Poses the skeleton at the specified time for this animation.
	* @param lastTime The last time the animation was applied.
	* @param events Any triggered events are added. May be null.*/
	SP_API void
	spAnimation_apply(const spAnimation *self, struct spSkeleton *skeleton, float lastTime, float time, int loop,
					spEvent **events, int *eventsCount, float alpha, spMixBlend blend, spMixDirection direction);
	SP_API void spTimeline_dispose(spTimeline *self);

	SP_API void
	spTimeline_apply(spTimeline *self, struct spSkeleton *skeleton, float lastTime, float time, spEvent **firedEvents,
					int *eventsCount, float alpha, spMixBlend blend, spMixDirection direction);

	SP_API void
	spTimeline_setBezier(spTimeline *self, int bezier, int frame, float value, float time1, float value1, float cx1,
						float cy1, float cx2, float cy2, float time2, float value2);

	SP_API float spTimeline_getDuration(const spTimeline *self);
	SP_API void spCurveTimeline_setLinear(spCurveTimeline *self, int frameIndex);

	SP_API void spCurveTimeline_setStepped(spCurveTimeline *self, int frameIndex);

	/* Sets the control handle positions for an interpolation bezier curve used to transition from this keyframe to the next.
	* cx1 and cx2 are from 0 to 1, representing the percent of time between the two keyframes. cy1 and cy2 are the percent of
	* the difference between the keyframe's values. */
	SP_API void spCurveTimeline_setCurve(spCurveTimeline *self, int frameIndex, float cx1, float cy1, float cx2, float cy2);

	SP_API float spCurveTimeline_getCurvePercent(const spCurveTimeline *self, int frameIndex, float percent);

	SP_API void spCurveTimeline1_setFrame(spCurveTimeline1 *self, int frame, float time, float value);

	SP_API float spCurveTimeline1_getCurveValue(spCurveTimeline1 *self, float time);

	SP_API void spCurveTimeline2_setFrame(spCurveTimeline1 *self, int frame, float time, float value1, float value2);

	SP_API spRotateTimeline *spRotateTimeline_create(int frameCount, int bezierCount, int boneIndex);

	SP_API void spRotateTimeline_setFrame(spRotateTimeline *self, int frameIndex, float time, float angle);

	SP_API spTranslateTimeline *spTranslateTimeline_create(int frameCount, int bezierCount, int boneIndex);

	SP_API void spTranslateTimeline_setFrame(spTranslateTimeline *self, int frameIndex, float time, float x, float y);

	SP_API spTranslateXTimeline *spTranslateXTimeline_create(int frameCount, int bezierCount, int boneIndex);

	SP_API void spTranslateXTimeline_setFrame(spTranslateXTimeline *self, int frame, float time, float x);

	SP_API spTranslateYTimeline *spTranslateYTimeline_create(int frameCount, int bezierCount, int boneIndex);

	SP_API void spTranslateYTimeline_setFrame(spTranslateYTimeline *self, int frame, float time, float y);

	SP_API spScaleTimeline *spScaleTimeline_create(int frameCount, int bezierCount, int boneIndex);

	SP_API void spScaleTimeline_setFrame(spScaleTimeline *self, int frameIndex, float time, float x, float y);

	SP_API spScaleXTimeline *spScaleXTimeline_create(int frameCount, int bezierCount, int boneIndex);

	SP_API void spScaleXTimeline_setFrame(spScaleXTimeline *self, int frame, float time, float x);

	SP_API spScaleYTimeline *spScaleYTimeline_create(int frameCount, int bezierCount, int boneIndex);

	SP_API void spScaleYTimeline_setFrame(spScaleYTimeline *self, int frame, float time, float y);

	SP_API spShearTimeline *spShearTimeline_create(int frameCount, int bezierCount, int boneIndex);

	SP_API void spShearTimeline_setFrame(spShearTimeline *self, int frameIndex, float time, float x, float y);

	SP_API spShearXTimeline *spShearXTimeline_create(int frameCount, int bezierCount, int boneIndex);

	SP_API void spShearXTimeline_setFrame(spShearXTimeline *self, int frame, float time, float x);

	SP_API spShearYTimeline *spShearYTimeline_create(int frameCount, int bezierCount, int boneIndex);

	SP_API void spShearYTimeline_setFrame(spShearYTimeline *self, int frame, float time, float x);

	SP_API spRGBATimeline *spRGBATimeline_create(int framesCount, int bezierCount, int slotIndex);

	SP_API void
	spRGBATimeline_setFrame(spRGBATimeline *self, int frameIndex, float time, float r, float g, float b, float a);

	SP_API spRGBTimeline *spRGBTimeline_create(int framesCount, int bezierCount, int slotIndex);

	SP_API void spRGBTimeline_setFrame(spRGBTimeline *self, int frameIndex, float time, float r, float g, float b);

	SP_API spAlphaTimeline *spAlphaTimeline_create(int frameCount, int bezierCount, int slotIndex);

	SP_API void spAlphaTimeline_setFrame(spAlphaTimeline *self, int frame, float time, float x);

	SP_API spRGBA2Timeline *spRGBA2Timeline_create(int framesCount, int bezierCount, int slotIndex);

	SP_API void
	spRGBA2Timeline_setFrame(spRGBA2Timeline *self, int frameIndex, float time, float r, float g, float b, float a,
						 float r2, float g2, float b2);

	SP_API spRGB2Timeline *spRGB2Timeline_create(int framesCount, int bezierCount, int slotIndex);

	SP_API void
	spRGB2Timeline_setFrame(spRGB2Timeline *self, int frameIndex, float time, float r, float g, float b, float r2, float g2,
							float b2);

	SP_API spAttachmentTimeline *spAttachmentTimeline_create(int framesCount, int SlotIndex);

	/* @param attachmentName May be 0. */
	SP_API void
	spAttachmentTimeline_setFrame(spAttachmentTimeline *self, int frameIndex, float time, const char *attachmentName);

	SP_API spDeformTimeline *
	spDeformTimeline_create(int framesCount, int frameVerticesCount, int bezierCount, int slotIndex,
						spVertexAttachment *attachment);

	SP_API void spDeformTimeline_setFrame(spDeformTimeline *self, int frameIndex, float time, float *vertices);

	SP_API spSequenceTimeline *spSequenceTimeline_create(int framesCount, int slotIndex, spAttachment *attachment);

	SP_API void spSequenceTimeline_setFrame(spSequenceTimeline *self, int frameIndex, float time, int mode, int index, float delay);
	
	SP_API spEventTimeline *spEventTimeline_create(int framesCount);

	SP_API void spEventTimeline_setFrame(spEventTimeline *self, int frameIndex, spEvent *event);

	SP_API spDrawOrderTimeline *spDrawOrderTimeline_create(int framesCount, int slotsCount);

	SP_API void spDrawOrderTimeline_setFrame(spDrawOrderTimeline *self, int frameIndex, float time, const int *drawOrder);

	SP_API spIkConstraintTimeline *
	spIkConstraintTimeline_create(int framesCount, int bezierCount, int transformConstraintIndex);

	SP_API void
	spIkConstraintTimeline_setFrame(spIkConstraintTimeline *self, int frameIndex, float time, float mix, float softness,
								int bendDirection, int /*boolean*/ compress, int /**boolean**/ stretch);

	SP_API spTransformConstraintTimeline *
	spTransformConstraintTimeline_create(int framesCount, int bezierCount, int transformConstraintIndex);

	SP_API void
	spTransformConstraintTimeline_setFrame(spTransformConstraintTimeline *self, int frameIndex, float time, float mixRotate,
									   float mixX, float mixY, float mixScaleX, float mixScaleY, float mixShearY);

	SP_API spPathConstraintPositionTimeline *
	spPathConstraintPositionTimeline_create(int framesCount, int bezierCount, int pathConstraintIndex);

	SP_API void
	spPathConstraintPositionTimeline_setFrame(spPathConstraintPositionTimeline *self, int frameIndex, float time,
										  float value);

	SP_API spPathConstraintSpacingTimeline *
	spPathConstraintSpacingTimeline_create(int framesCount, int bezierCount, int pathConstraintIndex);

	SP_API void spPathConstraintSpacingTimeline_setFrame(spPathConstraintSpacingTimeline *self, int frameIndex, float time,
													 float value);

	SP_API spPathConstraintMixTimeline *
	spPathConstraintMixTimeline_create(int framesCount, int bezierCount, int pathConstraintIndex);

	SP_API void
	spPathConstraintMixTimeline_setFrame(spPathConstraintMixTimeline *self, int frameIndex, float time, float mixRotate,
									 float mixX, float mixY);


	// _SP_ARRAY_DECLARE_TYPE(spPropertyIdArray, spPropertyId)
	spPropertyIdArray_create :: proc(initialCapacity: cc.int) -> ^spPropertyIdArray ---
	spPropertyIdArray_dispose :: proc(self: ^spPropertyIdArray) ---
	spPropertyIdArray_clear :: proc(self: ^spPropertyIdArray) ---
	spPropertyIdArray_setSize :: proc(self: ^spPropertyIdArray, newSize: cc.int) -> ^spPropertyIdArray ---
	spPropertyIdArray_ensureCapacity :: proc(self: ^spPropertyIdArray, newCapacity: cc.int) ---
	spPropertyIdArray_add :: proc(self: ^spPropertyIdArray, value: spPropertyId) ---
	spPropertyIdArray_addAll :: proc(self: ^spPropertyIdArray, other: ^spPropertyIdArray) ---
	spPropertyIdArray_addAllValues :: proc(self: ^spPropertyIdArray, values: [^]spPropertyId, offset: cc.int, count: cc.int) ---
	spPropertyIdArray_removeAt :: proc(self: ^spPropertyIdArray, index: cc.int) ---
	spPropertyIdArray_contains :: proc(self: ^spPropertyIdArray, value: spPropertyId) -> cc.bool ---
	spPropertyIdArray_pop :: proc(self:^spPropertyIdArray) -> spPropertyId ---
	spPropertyIdArray_peek :: proc(self: ^spPropertyIdArray) -> spPropertyId ---

	// _SP_ARRAY_DECLARE_TYPE(spTimelineArray, spTimeline*)
	spTimelineArray_create :: proc(initialCapacity: cc.int) -> ^spTimelineArray ---
	spTimelineArray_dispose :: proc(self: ^spTimelineArray) ---
	spTimelineArray_clear :: proc(self: ^spTimelineArray) ---
	spTimelineArray_setSize :: proc(self: ^spTimelineArray, newSize: cc.int) -> ^spTimelineArray ---
	spTimelineArray_ensureCapacity :: proc(self: ^spTimelineArray, newCapacity: cc.int) ---
	spTimelineArray_add :: proc(self: ^spTimelineArray, value: ^spTimeline) ---
	spTimelineArray_addAll :: proc(self: ^spTimelineArray, other: ^spTimelineArray) ---
	spTimelineArray_addAllValues :: proc(self: ^spTimelineArray, values: [^]^spTimeline, offset: cc.int, count: cc.int) ---
	spTimelineArray_removeAt :: proc(self: ^spTimelineArray, index: cc.int) ---
	spTimelineArray_contains :: proc(self: ^spTimelineArray, value: ^spTimeline) -> cc.bool ---
	spTimelineArray_pop :: proc(self:^spTimelineArray) -> ^spTimeline ---
	spTimelineArray_peek :: proc(self: ^spTimelineArray) -> ^spTimeline ---

	// [AnimationState.h] ---
	/* @param data May be 0 for no mixing. */
	spAnimationState_create :: proc(data: ^spAnimationStateData) -> ^spAnimationState ---
	spAnimationState_dispose :: proc(self: ^spAnimationState) ---
	spAnimationState_update :: proc(self: ^spAnimationState, delta: cc.float) ---
	spAnimationState_apply :: proc(self: ^spAnimationState, skeleton: ^spSkeleton) -> cc.bool ---
	spAnimationState_clearTracks :: proc(self: ^spAnimationState) ---
	spAnimationState_clearTrack :: proc(self: ^spAnimationState, trackIndex: cc.int) ---
	/** Set the current animation. Any queued animations are cleared. */
	spAnimationState_setAnimationByName :: proc(self: ^spAnimationState, trackIndex: cc.int, animationName: cstring, loop: cc.bool) -> ^spTrackEntry ---
	spAnimationState_setAnimation :: proc(self: ^spAnimationState, trackIndex: cc.int, animation: ^spAnimation, loop: cc.bool) -> ^spTrackEntry ---
	/** Adds an animation to be played delay seconds after the current or last queued animation, taking into account any mix
	* duration. */
	spAnimationState_addAnimationByName :: proc(self: ^spAnimationState, trackIndex: cc.int, animationName: cstring, loop: cc.bool, delay: cc.float) -> ^spTrackEntry ---
	spAnimationState_addAnimation :: proc(self: ^spAnimationState, trackIndex: cc.int, animation: ^spAnimation, loop: cc.bool, delay: cc.float) -> ^spTrackEntry ---
	spAnimationState_setEmptyAnimation :: proc(self: ^spAnimationState, trackIndex: cc.int, mixDuration: cc.float) -> ^spTrackEntry ---
	spAnimationState_addEmptyAnimation :: proc(self: ^spAnimationState, trackIndex: cc.int, mixDuration: cc.float, delay: cc.float) -> ^spTrackEntry ---
	spAnimationState_setEmptyAnimations :: proc(self: ^spAnimationState, mixDuration: cc.float) ---
	spAnimationState_getCurrent :: proc(self: ^spAnimationState, trackIndex: cc.int) -> ^spTrackEntry ---
	spAnimationState_clearListenerNotifications :: proc(self: ^spAnimationState) ---
	spTrackEntry_getAnimationTime :: proc(entry: ^spTrackEntry) -> cc.float ---
	spTrackEntry_getTrackComplete :: proc(entry: ^spTrackEntry) -> cc.float ---
	spAnimationState_clearNext :: proc(self: ^spAnimationState, entry: ^spTrackEntry) ---
	/** Use this to dispose static memory before your app exits to appease your memory leak detector*/
	spAnimationState_disposeStatics :: proc() ---

	// _SP_ARRAY_DECLARE_TYPE(spTrackEntryArray, spTrackEntry*)
	spTrackEntryArray_create :: proc(initialCapacity: cc.int) -> ^spTrackEntryArray ---
	spTrackEntryArray_dispose :: proc(self: ^spTrackEntryArray) ---
	spTrackEntryArray_clear :: proc(self: ^spTrackEntryArray) ---
	spTrackEntryArray_setSize :: proc(self: ^spTrackEntryArray, newSize: cc.int) -> ^spTrackEntryArray ---
	spTrackEntryArray_ensureCapacity :: proc(self: ^spTrackEntryArray, newCapacity: cc.int) ---
	spTrackEntryArray_add :: proc(self: ^spTrackEntryArray, value: ^spTrackEntry) ---
	spTrackEntryArray_addAll :: proc(self: ^spTrackEntryArray, other: ^spTrackEntryArray) ---
	spTrackEntryArray_addAllValues :: proc(self: ^spTrackEntryArray, values: [^]^spTrackEntry, offset: cc.int, count: cc.int) ---
	spTrackEntryArray_removeAt :: proc(self: ^spTrackEntryArray, index: cc.int) ---
	spTrackEntryArray_contains :: proc(self: ^spTrackEntryArray, value: ^spTrackEntry) -> cc.bool ---
	spTrackEntryArray_pop :: proc(self: ^spTrackEntryArray) -> ^spTrackEntry ---
	spTrackEntryArray_peek :: proc(self: ^spTrackEntryArray) -> ^spTrackEntry ---


	// [AnimationStateData.h] ---
	spAnimationStateData_create :: proc(skeletonData: ^spSkeletonData) -> ^spAnimationStateData ---
	spAnimationStateData_dispose :: proc(self: ^spAnimationStateData) ---
	spAnimationStateData_setMixByName :: proc(self: ^spAnimationStateData, fromName: cstring, toName: cstring, duration: cc.float) ---
	spAnimationStateData_setMix :: proc(self: ^spAnimationStateData, from: ^spAnimation, to: ^spAnimation, duration: cc.float) ---
	/* Returns 0 if there is no mixing between the animations. */
	spAnimationStateData_getMix :: proc(self: ^spAnimationStateData, from: ^spAnimation, to: ^spAnimation) -> cc.float ---

	// [Array.h] ---
	// NOTE(devon): ARRAY DEC TEMPLATE
	// name##_create :: proc(initialCapacity: cc.int) -> ^name ---
	// name##_dispose :: proc(self: ^name) ---
	// name##_clear :: proc(self: ^name) ---
	// name##_setSize :: proc(self: ^name, newSize: cc.int) -> ^name ---
	// name##_ensureCapacity :: proc(self: ^name, newCapacity: cc.int) ---
	// name##_add :: proc(self: ^name, value: T) ---
	// name##_addAll :: proc(self: ^name, other: ^name) ---
	// name##_addAllValues :: proc(self: ^name, values: [^]T, offset: cc.int, count: cc.int) ---
	// name##_removeAt :: proc(self: ^name, index: cc.int) ---
	// name##_contains :: proc(self: ^name, value: T) -> cc.bool ---
	// name##_pop :: proc(self:^name) -> T ---
	// name##_peek :: proc(self: ^name) -> T ---

	// [Atlas.h] ---
	spAtlasPage_create :: proc(atlas: ^spAtlas, name: cstring) -> ^spAtlasPage ---
	spAtlasPage_dispose :: proc(self: ^spAtlasPage) ---
	spAtlasRegion_create :: proc() -> ^spAtlasRegion ---
	spAtlasRegion_dispose :: proc(self: ^spAtlasRegion) ---
	/* Image files referenced in the atlas file will be prefixed with dir. */
	spAtlas_create :: proc(data: cstring, length: cc.int, dir: cstring, rendererObject: rawptr) -> ^spAtlas ---
	/* Image files referenced in the atlas file will be prefixed with the directory containing the atlas file. */
	spAtlas_createFromFile :: proc(path: cstring, rendererObject: rawptr) -> ^spAtlas ---
	spAtlas_dispose :: proc(atlas: ^spAtlas) ---
	/* Returns 0 if the region was not found. */
	spAtlas_findRegion :: proc(self: ^spAtlas, name: cstring) -> ^spAtlasRegion ---

	spKeyValueArray_create :: proc(initialCapacity: cc.int) -> ^spKeyValueArray ---
	spKeyValueArray_dispose :: proc(self: ^spKeyValueArray) ---
	spKeyValueArray_clear :: proc(self: ^spKeyValueArray) ---
	spKeyValueArray_setSize :: proc(self: ^spKeyValueArray, newSize: cc.int) -> ^spKeyValueArray ---
	spKeyValueArray_ensureCapacity :: proc(self: ^spKeyValueArray, newCapacity: cc.int) ---
	spKeyValueArray_add :: proc(self: ^spKeyValueArray, value: spKeyValue) ---
	spKeyValueArray_addAll :: proc(self: ^spKeyValueArray, other: ^spKeyValueArray) ---
	spKeyValueArray_addAllValues :: proc(self: ^spKeyValueArray, values: [^]spKeyValue, offset: cc.int, count: cc.int) ---
	spKeyValueArray_removeAt :: proc(self: ^spKeyValueArray, index: cc.int) ---
	spKeyValueArray_contains :: proc(self: ^spKeyValueArray, value: spKeyValue) -> cc.bool ---
	spKeyValueArray_pop :: proc(self: ^spKeyValueArray) -> spKeyValue ---
	spKeyValueArray_peek :: proc(self: ^spKeyValueArray) -> spKeyValue ---


	// [AtlasAttachmentLoader.h] ---
	spAtlasAttachmentLoader_create :: proc(atlas: ^spAtlas) -> spAtlasAttachmentLoader ---

	// [Attachment.h] ---
	spAttachment_dispose :: proc(self: ^spAttachment) ---
	spAttachment_copy :: proc(self: ^spAttachment) -> ^spAttachment ---

	// [AttachmentLoader.h] ---
	spAttachmentLoader_dispose :: proc(self: ^spAttachmentLoader) ---
	/* Called to create each attachment. Returns 0 to not load an attachment. If 0 is returned and _spAttachmentLoader_setError was
	* called, an error occurred. */
	spAttachmentLoader_createAttachment :: proc(self: ^spAttachmentLoader, skin: ^spSkin, type: spAttachmentType, name: cstring, path: cstring, sequence: ^spSequence) -> ^spAttachment ---
	/* Called after the attachment has been fully configured. */
	spAttachmentLoader_configureAttachment :: proc(self: ^spAttachmentLoader, attachment: ^spAttachment) ---
	/* Called just before the attachment is disposed. This can release allocations made in spAttachmentLoader_configureAttachment. */
	spAttachmentLoader_disposeAttachment :: proc(self: ^spAttachmentLoader, attachment: ^spAttachment) ---

	// [Bone.h] ---
	spBone_setYDown :: proc(yDown: cc.bool) ---
	spBone_isYDown :: proc() -> cc.bool ---
	/* @param parent May be 0. */
	spBone_create :: proc(data: ^spBoneData, skeleton: ^spSkeleton, parent: ^spBone) -> ^spBone ---
	spBone_dispose :: proc(self: ^spBone) ---
	spBone_setToSetupPose :: proc(self: ^spBone) ---
	spBone_update :: proc(self: ^spBone) ---
	spBone_updateWorldTransform :: proc(self: ^spBone) ---
	spBone_updateWorldTransformWith :: proc(self: ^spBone, x: cc.float, y: cc.float, rotation: cc.float, scaleX: cc.float, scaleY: cc.float, shearX: cc.float, shearY: cc.float) ---
	spBone_getWorldRotationX :: proc(self: ^spBone) -> cc.float ---
	spBone_getWorldRotationY :: proc(self: ^spBone) -> cc.float ---
	spBone_getWorldScaleX :: proc(self: ^spBone) -> cc.float ---
	spBone_getWorldScaleY :: proc(self: ^spBone) -> cc.float ---
	spBone_updateAppliedTransform :: proc(self: ^spBone) ---
	spBone_worldToLocal :: proc(self: ^spBone, worldX: cc.float, worldY: cc.float, localX: [^]cc.float, localY: [^]cc.float) ---
	spBone_localToWorld :: proc(self: ^spBone, localX: cc.float, localY: cc.float, worldX: [^]cc.float, worldY: [^]cc.float) ---
	spBone_worldToLocalRotation :: proc(self: ^spBone, worldRotation: cc.float) -> cc.float ---
	spBone_localToWorldRotation :: proc(self: ^spBone, localRotation: cc.float) -> cc.float ---
	spBone_rotateWorld :: proc(self: ^spBone, degrees: cc.float) ---

	// [BoneData.h] ---
	spBoneData_create :: proc(index: cc.int, name: cstring, parent: ^spBoneData) -> ^spBoneData ---
	spBoneData_dispose :: proc(self: ^spBoneData) ---

	// [BoundingBoxAttachment.h] ---
	spBoundingBoxAttachment_create :: proc(name: cstring) -> ^spBoundingBoxAttachment ---

	// [ClippingAttachment.h] ---
	_spClippingAttachment_dispose :: proc(self: ^spAttachment) ---
	spClippingAttachment_create :: proc(name: cstring) -> ^spClippingAttachment ---

	// [Color.h] ---
	spColor_create :: proc() -> ^spColor ---
	spColor_dispose :: proc(self: ^spColor) ---
	spColor_setFromFloats :: proc(color: ^spColor, r: cc.float, g: cc.float, b: cc.float, a: cc.float) ---
	spColor_setFromFloats3 :: proc(self: ^spColor, r: cc.float, g: cc.float, b: cc.float) ---
	spColor_setFromColor :: proc(color: ^spColor, otherColor: ^spColor) ---
	spColor_setFromColor3 :: proc(self: ^spColor, otherColor: ^spColor) ---
	spColor_addFloats :: proc(color: ^spColor, r: cc.float, g: cc.float, b: cc.float, a: cc.float) ---
	spColor_addFloats3 :: proc(color: ^spColor, r: cc.float, g: cc.float, b: cc.float) ---
	spColor_addColor :: proc(color: ^spColor, otherColor: ^spColor) ---
	spColor_clamp :: proc(color: ^spColor) ---

	// [Debug.h] ---
	spDebug_printSkeletonData :: proc(skeletonData: ^spSkeletonData) ---
	spDebug_printAnimation :: proc(animation: ^spAnimation) ---
	spDebug_printTimeline :: proc(timeline: ^spTimeline) ---
	spDebug_printBoneDatas :: proc(boneDatas: [^]^spBoneData, numBoneDatas: cc.int) ---
	spDebug_printBoneData :: proc(boneData: ^spBoneData) ---
	spDebug_printSkeleton :: proc(skeleton: ^spSkeleton) ---
	spDebug_printBones :: proc(bones: [^]^spBone, numBones: cc.int) ---
	spDebug_printBone :: proc(bone: ^spBone) ---
	spDebug_printFloats :: proc(values: [^]cc.float, numFloats: cc.int) ---

	// [Event.h] ---
	spEvent_create :: proc(time: cc.float, data: ^spEventData) -> ^spEvent ---
	spEvent_dispose :: proc(self: ^spEvent) ---

	// [EventData.h] ---
	spEventData_create :: proc(name: cstring) -> ^spEventData ---
	spEventData_dispose :: proc(self: ^spEventData) ---

	// [extension.h] ---

	// [IkConstraint.h] ---
	spIkConstraint_create :: proc(data: ^spIkConstraintData, skeleton: ^spSkeleton) -> ^spIkConstraint ---
	spIkConstraint_dispose :: proc(self: ^spIkConstraint) ---
	spIkConstraint_update :: proc(self: ^spIkConstraint) ---
	spIkConstraint_apply1 :: proc(bone: ^spBone, targetX: cc.float, targetY: cc.float, compress: cc.bool, stretch: cc.bool, uniform: cc.bool, alpha: cc.float) ---
	spIkConstraint_apply2 :: proc(parent: ^spBone, child: ^spBone, targetX: cc.float, targetY: cc.float, bendDirection: cc.int, stretch: cc.bool, uniform: cc.bool, softness: cc.float, alpha: cc.float) ---

	// [IkConstraintData.h] ---
	spIkConstraintData_create :: proc(name: cstring) -> ^spIkConstraintData ---
	spIkConstraintData_dispose :: proc(self: ^spIkConstraintData) ---

	// [MeshAttachment.h] ---
	spMeshAttachment_create :: proc(name: cstring) -> ^spMeshAttachment ---
	spMeshAttachment_updateRegion :: proc(self: ^spMeshAttachment) ---
	spMeshAttachment_setParentMesh :: proc(self: ^spMeshAttachment, parentMesh: ^spMeshAttachment) ---
	spMeshAttachment_newLinkedMesh :: proc(self: ^spMeshAttachment) -> ^spMeshAttachment ---

	// [PathAttachment.h] ---
	spPathAttachment_create :: proc(name: cstring) -> ^spPathAttachment ---

	// [PointConstraint.h] ---
	spPathConstraint_create :: proc(data: ^spPathConstraintData, skeleton: ^spSkeleton) -> ^spPathConstraint ---
	spPathConstraint_dispose :: proc(self: ^spPathConstraint) ---
	spPathConstraint_update :: proc(self: ^spPathConstraint) ---
	spPathConstraint_computeWorldPositions :: proc(self: ^spPathConstraint, path: ^spPathAttachment, spacesCount: cc.int, tangents: cc.bool) -> cc.float ---

	// [PointConstraintData.h] ---
	spPathConstraintData_create :: proc(name: cstring) -> ^spPathConstraintData ---
	spPathConstraintData_dispose :: proc(self: ^spPathConstraintData) ---

	// [PointAttachment.h] ---
	spPointAttachment_create :: proc(name: cstring) -> ^spPointAttachment ---
	spPointAttachment_computeWorldPosition :: proc(self: ^spPointAttachment, bone: ^spBone, x: [^]cc.float, y: [^]cc.float) ---
	spPointAttachment_computeWorldRotation :: proc(self: ^spPointAttachment, bone: ^spBone) -> cc.float ---

	// [RegionAttachment.h] ---
	spRegionAttachment_create :: proc(name: cstring) -> ^spRegionAttachment ---
	spRegionAttachment_updateRegion :: proc(self: ^spRegionAttachment) ---
	spRegionAttachment_computeWorldVertices :: proc(self: ^spRegionAttachment, slot: ^spSlot, vertices: [^]cc.float, offset: cc.int, stride: cc.int) ---

	// [Sequence.h] ---
	spSequence_create :: proc(numRegions: cc.int) -> ^spSequence ---
	spSequence_dispose :: proc(self: ^spSequence) ---
	spSequence_copy :: proc(self: ^spSequence) -> ^spSequence ---
	spSequence_apply :: proc(self: ^spSequence, slot: ^spSlot, attachment: ^spAttachment) ---
	spSequence_getPath :: proc(self: ^spSequence, basePath: cstring, index: cc.int, path: cstring) ---

	spTextureRegionArray_create :: proc(initialCapacity: cc.int) -> ^spTextureRegionArray ---
	spTextureRegionArray_dispose :: proc(self: ^spTextureRegionArray) ---
	spTextureRegionArray_clear :: proc(self: ^spTextureRegionArray) ---
	spTextureRegionArray_setSize :: proc(self: ^spTextureRegionArray, newSize: cc.int) -> ^spTextureRegionArray ---
	spTextureRegionArray_ensureCapacity :: proc(self: ^spTextureRegionArray, newCapacity: cc.int) ---
	spTextureRegionArray_add :: proc(self: ^spTextureRegionArray, value: ^spTextureRegion) ---
	spTextureRegionArray_addAll :: proc(self: ^spTextureRegionArray, other: ^spTextureRegionArray) ---
	spTextureRegionArray_addAllValues :: proc(self: ^spTextureRegionArray, values: [^]^spTextureRegion, offset: cc.int, count: cc.int) ---
	spTextureRegionArray_removeAt :: proc(self: ^spTextureRegionArray, index: cc.int) ---
	spTextureRegionArray_contains :: proc(self: ^spTextureRegionArray, value: ^spTextureRegion) -> cc.bool ---
	spTextureRegionArray_pop :: proc(self: ^spTextureRegionArray) -> ^spTextureRegion ---
	spTextureRegionArray_peek :: proc(self: ^spTextureRegionArray) -> ^spTextureRegion ---

	// [Skeleton.h] ---
	spSkeleton_create :: proc(data: ^spSkeletonData) -> ^spSkeleton ---
	spSkeleton_dispose :: proc(self: ^spSkeleton) ---
	/* Caches information about bones and constraints. Must be called if bones or constraints, or weighted path attachments
	* are added or removed. */
	spSkeleton_updateCache :: proc(self: ^spSkeleton) ---
	spSkeleton_updateWorldTransform :: proc(self: ^spSkeleton) ---
	/* Sets the bones, constraints, and slots to their setup pose values. */
	spSkeleton_setToSetupPose :: proc(self: ^spSkeleton) ---
	/* Sets the bones and constraints to their setup pose values. */
	spSkeleton_setBonesToSetupPose :: proc(self: ^spSkeleton) ---
	spSkeleton_setSlotsToSetupPose :: proc(self: ^spSkeleton) ---
	/* Returns 0 if the bone was not found. */
	spSkeleton_findBone :: proc(self: ^spSkeleton, boneName: cstring) -> ^spBone ---
	/* Returns 0 if the slot was not found. */
	spSkeleton_findSlot :: proc(self: ^spSkeleton, slotName: cstring) -> ^spSlot ---
	/* Sets the skin used to look up attachments before looking in the SkeletonData defaultSkin. Attachments from the new skin are
	* attached if the corresponding attachment from the old skin was attached. If there was no old skin, each slot's setup mode
	* attachment is attached from the new skin.
	* @param skin May be 0.*/
	spSkeleton_setSkin :: proc(self: ^spSkeleton, skin: ^spSkin) ---
	/* Returns 0 if the skin was not found. See spSkeleton_setSkin.
	* @param skinName May be 0. */
	spSkeleton_setSkinByName :: proc(self: ^spSkeleton, skinName: cstring) -> cc.int ---
	/* Returns 0 if the slot or attachment was not found. */
	spSkeleton_getAttachmentForSlotName :: proc(self: ^spSkeleton, slotName: cstring, attachmentName: cstring) -> ^spAttachment ---
	/* Returns 0 if the slot or attachment was not found. */
	spSkeleton_getAttachmentForSlotIndex :: proc(self: ^spSkeleton, slotIndex: cc.int, attachmentName: cstring) -> ^spAttachment ---
	/* Returns 0 if the slot or attachment was not found.
	* @param attachmentName May be 0. */
	spSkeleton_setAttachment :: proc(self: ^spSkeleton, slotName: cstring, attachmentName: cstring) -> cc.int ---
	/* Returns 0 if the IK constraint was not found. */
	spSkeleton_findIkConstraint :: proc(self: ^spSkeleton, constraintName: cstring) -> ^spIkConstraint ---
	/* Returns 0 if the transform constraint was not found. */
	spSkeleton_findTransformConstraint :: proc(self: ^spSkeleton, constraintName: cstring) -> ^spTransformConstraint ---
	/* Returns 0 if the path constraint was not found. */
	spSkeleton_findPathConstraint :: proc(self: ^spSkeleton, constraintName: cstring) -> ^spPathConstraint ---

	// [SkeletonBinary.h] ---
	spSkeletonBinary_createWithLoader :: proc(attachmentLoader: ^spAttachmentLoader) -> ^spSkeletonBinary ---
	spSkeletonBinary_create :: proc(atlas: ^spAtlas) -> ^spSkeletonBinary ---
	spSkeletonBinary_dispose :: proc(self: ^spSkeletonBinary) ---
	spSkeletonBinary_readSkeletonData :: proc(self: ^spSkeletonBinary, binary: cc.uchar, length: cc.int) -> ^spSkeletonData ---
	spSkeletonBinary_readSkeletonDataFile :: proc(self: ^spSkeletonBinary, path: cstring) -> ^spSkeletonData ---

	// [SkeletonBounds.h] ---
	spPolygon_create :: proc(capacity: cc.int) -> ^spPolygon ---
	spPolygon_dispose :: proc(self: ^spPolygon) ---
	spPolygon_containsPoint :: proc(polygon: ^spPolygon, x: cc.float, y: cc.float) -> cc.bool ---
	spPolygon_intersectsSegment :: proc(polygon: ^spPolygon, x1: cc.float, y1: cc.float, x2: cc.float, y2: cc.float) -> cc.bool ---

	spSkeletonBounds_create :: proc() -> ^spSkeletonBounds ---
	spSkeletonBounds_dispose :: proc(self: ^spSkeletonBounds) ---
	spSkeletonBounds_update :: proc(self: ^spSkeletonBounds, skeleton: ^spSkeleton, updateAabb: cc.bool) ---
	/** Returns true if the axis aligned bounding box contains the point. */
	spSkeletonBounds_aabbContainsPoint :: proc(self: ^spSkeletonBounds, x: cc.float, y: cc.float) -> cc.bool ---
	/** Returns true if the axis aligned bounding box intersects the line segment. */
	spSkeletonBounds_aabbIntersectsSegment :: proc(self: ^spSkeletonBounds, x1: cc.float, y1: cc.float, x2: cc.float, y2: cc.float) -> cc.bool ---
	/** Returns true if the axis aligned bounding box intersects the axis aligned bounding box of the specified bounds. */
	spSkeletonBounds_aabbIntersectsSkeleton :: proc(self: ^spSkeletonBounds, bounds: ^spSkeletonBounds) -> cc.bool ---
	/** Returns the first bounding box attachment that contains the point, or null. When doing many checks, it is usually more
	* efficient to only call this method if spSkeletonBounds_aabbContainsPoint returns true. */
	spSkeletonBounds_containsPoint :: proc(self: ^spSkeletonBounds, x: cc.float, y: cc.float) -> ^spBoundingBoxAttachment ---
	/** Returns the first bounding box attachment that contains the line segment, or null. When doing many checks, it is usually
	* more efficient to only call this method if spSkeletonBounds_aabbIntersectsSegment returns true. */
	spSkeletonBounds_intersectsSegment :: proc(self: ^spSkeletonBounds, x1: cc.float, y1: cc.float, x2: cc.float, y2: cc.float) -> ^spBoundingBoxAttachment ---
	/** Returns the polygon for the specified bounding box, or null. */
	spSkeletonBounds_getPolygon :: proc(self: ^spSkeletonBounds, boundingBox: ^spBoundingBoxAttachment) -> ^spPolygon ---

	// [SkeletonClipping.h] ---
	spSkeletonClipping_create :: proc() -> ^spSkeletonClipping ---
	spSkeletonClipping_clipStart :: proc(self: ^spSkeletonClipping, slot: ^spSlot, clip: ^spClippingAttachment) -> cc.int ---
	spSkeletonClipping_clipEnd :: proc(self: ^spSkeletonClipping, slot: ^spSlot) ---
	spSkeletonClipping_clipEnd2 :: proc(self: ^spSkeletonClipping) ---
	spSkeletonClipping_isClipping :: proc(self: ^spSkeletonClipping) -> cc.bool ---
	spSkeletonClipping_clipTriangles :: proc(self: ^spSkeletonClipping, vertices: [^]cc.float, verticesLength: cc.int, triangles: [^]cc.ushort, trianglesLength: cc.int, uvs: [^]cc.float, stride: cc.int) ---
	spSkeletonClipping_dispose :: proc(self: ^spSkeletonClipping) ---

	// [SkeletonData.h] ---
	spSkeletonData_create :: proc() -> ^spSkeletonData ---
	spSkeletonData_dispose :: proc(self: ^spSkeletonData) ---
	spSkeletonData_findBone :: proc(self: ^spSkeletonData, boneName: cstring) -> ^spBoneData ---
	spSkeletonData_findSlot :: proc(self: ^spSkeletonData, slotName: cstring) -> ^spSlotData ---
	spSkeletonData_findSkin :: proc(self: ^spSkeletonData, skinName: cstring) -> ^spSkin ---
	spSkeletonData_findEvent :: proc(self: ^spSkeletonData, eventName: cstring) -> ^spEventData ---
	spSkeletonData_findAnimation :: proc(self: ^spSkeletonData, animationName: cstring) -> ^spAnimation ---
	spSkeletonData_findIkConstraint :: proc(self: ^spSkeletonData, constraintName: cstring) -> ^spIkConstraintData ---
	spSkeletonData_findTransformConstraint :: proc(self: ^spSkeletonData, constraintName: cstring) -> ^spTransformConstraintData ---
	spSkeletonData_findPathConstraint :: proc(self: ^spSkeletonData, constraintName: cstring) -> ^spPathConstraintData ---

	// [SkeletonJson.h] ---
	spSkeletonJson_createWithLoader :: proc(attachmentLoader: ^spAttachmentLoader) -> ^spSkeletonJson ---
	spSkeletonJson_create :: proc(atlas: ^spAtlas) -> ^spSkeletonJson ---
	spSkeletonJson_dispose :: proc(self: ^spSkeletonJson) ---
	spSkeletonJson_readSkeletonData :: proc(self: ^spSkeletonJson, json: cstring) -> ^spSkeletonData ---
	spSkeletonJson_readSkeletonDataFile :: proc(self: ^spSkeletonJson, path: cstring) -> ^spSkeletonData ---

	// [Skin.h] ---
	spSkin_create :: proc(name: cstring) -> ^spSkin ---
	spSkin_dispose :: proc(self: ^spSkin) ---
	/* The Skin owns the attachment. */
	spSkin_setAttachment :: proc(self: ^spSkin, slotIndex: cc.int, name: cstring, attachment: ^spAttachment) ---
	/* Returns 0 if the attachment was not found. */
	spSkin_getAttachment :: proc(self: ^spSkin, slotIndex: cc.int, name: cstring) -> ^spAttachment ---
	/* Returns 0 if the slot or attachment was not found. */
	spSkin_getAttachmentName :: proc(self: ^spSkin, slotIndex: cc.int, attachmentIndex: cc.int) -> cstring ---
	/** Attach each attachment in this skin if the corresponding attachment in oldSkin is currently attached. */
	spSkin_attachAll :: proc(self: ^spSkin, skeleton: ^spSkeleton, oldspSkin: ^spSkin) ---
	/** Adds all attachments, bones, and constraints from the specified skin to this skin. */
	spSkin_addSkin :: proc(self: ^spSkin, other: ^spSkin) ---
	/** Adds all attachments, bones, and constraints from the specified skin to this skin. Attachments are deep copied. */
	spSkin_copySkin :: proc(self: ^spSkin, other: ^spSkin) ---
	/** Returns all attachments in this skin. */
	spSkin_getAttachments :: proc(self: ^spSkin) -> ^spSkinEntry ---
	/** Clears all attachments, bones, and constraints. */
	spSkin_clear :: proc(self: ^spSkin) ---

	spBoneDataArray_create :: proc(initialCapacity: cc.int) -> ^spBoneDataArray ---
	spBoneDataArray_dispose :: proc(self: ^spBoneDataArray) ---
	spBoneDataArray_clear :: proc(self: ^spBoneDataArray) ---
	spBoneDataArray_setSize :: proc(self: ^spBoneDataArray, newSize: cc.int) -> ^spBoneDataArray ---
	spBoneDataArray_ensureCapacity :: proc(self: ^spBoneDataArray, newCapacity: cc.int) ---
	spBoneDataArray_add :: proc(self: ^spBoneDataArray, value: ^spBoneData) ---
	spBoneDataArray_addAll :: proc(self: ^spBoneDataArray, other: ^spBoneDataArray) ---
	spBoneDataArray_addAllValues :: proc(self: ^spBoneDataArray, values: [^]^spBoneData, offset: cc.int, count: cc.int) ---
	spBoneDataArray_removeAt :: proc(self: ^spBoneDataArray, index: cc.int) ---
	spBoneDataArray_contains :: proc(self: ^spBoneDataArray, value: ^spBoneData) -> cc.bool ---
	spBoneDataArray_pop :: proc(self: ^spBoneDataArray) -> ^spBoneData ---
	spBoneDataArray_peek :: proc(self: ^spBoneDataArray) -> ^spBoneData ---

	spIkConstraintDataArray_create :: proc(initialCapacity: cc.int) -> ^spIkConstraintDataArray ---
	spIkConstraintDataArray_dispose :: proc(self: ^spIkConstraintDataArray) ---
	spIkConstraintDataArray_clear :: proc(self: ^spIkConstraintDataArray) ---
	spIkConstraintDataArray_setSize :: proc(self: ^spIkConstraintDataArray, newSize: cc.int) -> ^spIkConstraintDataArray ---
	spIkConstraintDataArray_ensureCapacity :: proc(self: ^spIkConstraintDataArray, newCapacity: cc.int) ---
	spIkConstraintDataArray_add :: proc(self: ^spIkConstraintDataArray, value: ^spIkConstraintData) ---
	spIkConstraintDataArray_addAll :: proc(self: ^spIkConstraintDataArray, other: ^spIkConstraintDataArray) ---
	spIkConstraintDataArray_addAllValues :: proc(self: ^spIkConstraintDataArray, values: [^]^spIkConstraintData, offset: cc.int, count: cc.int) ---
	spIkConstraintDataArray_removeAt :: proc(self: ^spIkConstraintDataArray, index: cc.int) ---
	spIkConstraintDataArray_contains :: proc(self: ^spIkConstraintDataArray, value: ^spIkConstraintData) -> cc.bool ---
	spIkConstraintDataArray_pop :: proc(self: ^spIkConstraintDataArray) -> ^spIkConstraintData ---
	spIkConstraintDataArray_peek :: proc(self: ^spIkConstraintDataArray) -> ^spIkConstraintData ---

	spTransformConstraintDataArray_create :: proc(initialCapacity: cc.int) -> ^spTransformConstraintDataArray ---
	spTransformConstraintDataArray_dispose :: proc(self: ^spTransformConstraintDataArray) ---
	spTransformConstraintDataArray_clear :: proc(self: ^spTransformConstraintDataArray) ---
	spTransformConstraintDataArray_setSize :: proc(self: ^spTransformConstraintDataArray, newSize: cc.int) -> ^spTransformConstraintDataArray ---
	spTransformConstraintDataArray_ensureCapacity :: proc(self: ^spTransformConstraintDataArray, newCapacity: cc.int) ---
	spTransformConstraintDataArray_add :: proc(self: ^spTransformConstraintDataArray, value: ^spTransformConstraintData) ---
	spTransformConstraintDataArray_addAll :: proc(self: ^spTransformConstraintDataArray, other: ^spTransformConstraintDataArray) ---
	spTransformConstraintDataArray_addAllValues :: proc(self: ^spTransformConstraintDataArray, values: [^]^spTransformConstraintData, offset: cc.int, count: cc.int) ---
	spTransformConstraintDataArray_removeAt :: proc(self: ^spTransformConstraintDataArray, index: cc.int) ---
	spTransformConstraintDataArray_contains :: proc(self: ^spTransformConstraintDataArray, value: ^spTransformConstraintData) -> cc.bool ---
	spTransformConstraintDataArray_pop :: proc(self: ^spTransformConstraintDataArray) -> ^spTransformConstraintData ---
	spTransformConstraintDataArray_peek :: proc(self: ^spTransformConstraintDataArray) -> ^spTransformConstraintData ---

	spPathConstraintDataArray_create :: proc(initialCapacity: cc.int) -> ^spPathConstraintDataArray ---
	spPathConstraintDataArray_dispose :: proc(self: ^spPathConstraintDataArray) ---
	spPathConstraintDataArray_clear :: proc(self: ^spPathConstraintDataArray) ---
	spPathConstraintDataArray_setSize :: proc(self: ^spPathConstraintDataArray, newSize: cc.int) -> ^spPathConstraintDataArray ---
	spPathConstraintDataArray_ensureCapacity :: proc(self: ^spPathConstraintDataArray, newCapacity: cc.int) ---
	spPathConstraintDataArray_add :: proc(self: ^spPathConstraintDataArray, value: ^spPathConstraintData) ---
	spPathConstraintDataArray_addAll :: proc(self: ^spPathConstraintDataArray, other: ^spPathConstraintDataArray) ---
	spPathConstraintDataArray_addAllValues :: proc(self: ^spPathConstraintDataArray, values: [^]^spPathConstraintData, offset: cc.int, count: cc.int) ---
	spPathConstraintDataArray_removeAt :: proc(self: ^spPathConstraintDataArray, index: cc.int) ---
	spPathConstraintDataArray_contains :: proc(self: ^spPathConstraintDataArray, value: ^spPathConstraintData) -> cc.bool ---
	spPathConstraintDataArray_pop :: proc(self: ^spPathConstraintDataArray) -> ^spPathConstraintData ---
	spPathConstraintDataArray_peek :: proc(self: ^spPathConstraintDataArray) -> ^spPathConstraintData ---


	// [Slot.h] ---
	spSlot_create :: proc(data: ^spSlotData, bone: ^spBone) -> ^spSlot ---
	spSlot_dispose :: proc(self: ^spSlot) ---
	spSlot_setAttachment :: proc(self: ^spSlot, attachment: ^spAttachment) ---
	spSlot_setToSetupPose :: proc(self: ^spSlot) ---

	// [SlotData.h] ---
	spSlotData_create :: proc(index: cc.int, name: cstring, boneData: ^spBoneData) -> ^spSlotData ---
	spSlotData_dispose :: proc(self: ^spSlotData) ---
	spSlotData_setAttachmentName :: proc(self: ^spSlotData, attachmentName: cstring) ---

	// [TransformConstraint.h] ---
	spTransformConstraint_create :: proc(data: ^spTransformConstraintData, skeleton: ^spSkeleton) -> ^spTransformConstraint ---
	spTransformConstraint_dispose :: proc(self: ^spTransformConstraint) ---
	spTransformConstraint_update :: proc(self: ^spTransformConstraint) ---

	// [TransformConstraintData.h] ---
	spTransformConstraintData_create :: proc(name: cstring) -> ^spTransformConstraintData ---
	spTransformConstraintData_dispose :: proc(self: ^spTransformConstraintData) ---

	// [Triangulator.h] ---
	spTriangulator_create :: proc() -> ^spTriangulator ---
	spTriangulator_triangulate :: proc(self: ^spTriangulator, verticesArray: ^spFloatArray) -> ^spShortArray ---
	spTriangulator_decompose :: proc(self: ^spTriangulator, verticesArray: ^spFloatArray, triangles: ^spShortArray) -> ^spArrayFloatArray ---
	spTriangulator_dispose :: proc(self: ^spTriangulator) ---

	// [VertexAttachment.h] ---
	spVertexAttachment_computeWorldVertices :: proc(self: ^spVertexAttachment, slot: ^spSlot, start: cc.int, count: cc.int, worldVertices: [^]cc.float, offset: cc.int, stride: cc.int) ---
	spVertexAttachment_copyTo :: proc(self: ^spVertexAttachment, other: ^spVertexAttachment) ---
}

// void _spAtlasPage_createTexture(spAtlasPage *self, const char *path);

// void _spAtlasPage_disposeTexture(spAtlasPage *self);

// char *_spUtil_readFile(const char *path, int *length);
