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

	// [AnimationState.h] ---

	// [AnimationStateData.h] ---

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

	// [AtlasAttachmentLoader.h] ---

	// [Attachment.h] ---

	// [AttachmentLoader.h] ---

	// [Bone.h] ---

	// [BoneData.h] ---

	// [BoundingBoxAttachment.h] ---

	// [ClippingAttachment.h] ---

	// [Color.h] ---
	spColor_create :: proc() -> ^spColor ---
	spColor_dispose :: proc(self: ^spColor) ---
	spColor_setFromFloats :: proc(color: ^spColor, r: cc.float, g: cc.float, b: cc.float, a: cc.float) ---

	// [Debug.h] ---

	// [Event.h] ---

	// [EventData.h] ---
	spEventData_create :: proc(name: cstring) -> ^spEventData ---
	spEventData_dispose :: proc(self: ^spEventData) ---

	// [extension.h] ---

	// [IkConstraint.h] ---

	// [IkConstraintData.h] ---

	// [MeshAttachment.h] ---

	// [PathAttachment.h] ---

	// [PointConstraint.h] ---

	// [PointConstraintData.h] ---

	// [PointAttachment.h] ---

	// [RegionAttachment.h] ---

	// [Sequence.h] ---

	// [Skeleton.h] ---

	// [SkeletonBinary.h] ---

	// [SkeletonBounds.h] ---

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
