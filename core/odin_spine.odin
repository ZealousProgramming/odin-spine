package core

import c "core:c"
import lc "core:c/libc"
import "core:fmt"


#assert(size_of(rune) == size_of(c.int))

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
spMixBlends :: enum c.int {
	SP_MIX_BLEND_SETUP = 0,
	SP_MIX_BLEND_FIRST,
	SP_MIX_BLEND_REPLACE,
	SP_MIX_BLEND_ADD,
}

spMixDirection :: enum c.int {
	SP_MIX_DIRECTION_IN = 0,
	SP_MIX_DIRECTION_OUT,
}

spTimelineType :: enum c.int {
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

spProperty :: enum c.int {
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

spEventType :: enum c.int {
	SP_ANIMATION_START = 0,
	SP_ANIMATION_INTERRUPT,
	SP_ANIMATION_END,
	SP_ANIMATION_COMPLETE,
	SP_ANIMATION_DISPOSE,
	SP_ANIMATION_EVENT,
}

spAtlasFormat :: enum c.int {
	SP_ATLAS_UNKNOWN_FORMAT = 0,
	SP_ATLAS_ALPHA,
	SP_ATLAS_INTENSITY,
	SP_ATLAS_LUMINANCE_ALPHA,
	SP_ATLAS_RGB565,
	SP_ATLAS_RGBA4444,
	SP_ATLAS_RGB888,
	SP_ATLAS_RGBA8888,
}

spAtlasFilter :: enum c.int {
	SP_ATLAS_UNKNOWN_FILTER = 0,
	SP_ATLAS_NEAREST,
	SP_ATLAS_LINEAR,
	SP_ATLAS_MIPMAP,
	SP_ATLAS_MIPMAP_NEAREST_NEAREST,
	SP_ATLAS_MIPMAP_LINEAR_NEAREST,
	SP_ATLAS_MIPMAP_NEAREST_LINEAR,
	SP_ATLAS_MIPMAP_LINEAR_LINEAR,
}

spAtlasWrap :: enum c.int {
	SP_ATLAS_MIRROREDREPEAT = 0,
	SP_ATLAS_CLAMPTOEDGE,
	SP_ATLAS_REPEAT,
}

spAttachmentType :: enum c.int {
	SP_ATTACHMENT_REGION = 0,
	SP_ATTACHMENT_BOUNDING_BOX,
	SP_ATTACHMENT_MESH,
	SP_ATTACHMENT_LINKED_MESH,
	SP_ATTACHMENT_PATH,
	SP_ATTACHMENT_POINT,
	SP_ATTACHMENT_CLIPPING,
}

spTransformMode :: enum c.int {
	SP_TRANSFORMMODE_NORMAL = 0,
	SP_TRANSFORMMODE_ONLYTRANSLATION,
	SP_TRANSFORMMODE_NOROTATIONORREFLECTION,
	SP_TRANSFORMMODE_NOSCALE,
	SP_TRANSFORMMODE_NOSCALEORREFLECTION,
}

spPositionMode :: enum c.int {
	SP_POSITION_MODE_FIXED = 0,
	SP_POSITION_MODE_PERCENT,
}

spSpacingMode :: enum c.int {
	SP_SPACING_MODE_LENGTH = 0,
	SP_SPACING_MODE_FIXED,
	SP_SPACING_MODE_PERCENT,
	SP_SPACING_MODE_PROPORTIONAL,
}

spRotateMode :: enum c.int {
	SP_ROTATE_MODE_TANGENT = 0,
	SP_ROTATE_MODE_CHAIN,
	SP_ROTATE_MODE_CHAIN_SCALE,
}

spBlendMode :: enum c.int {
	SP_BLEND_MODE_NORMAL = 0, 
	SP_BLEND_MODE_ADDITIVE, 
	SP_BLEND_MODE_MULTIPLY, 
	SP_BLEND_MODE_SCREEN,
}



// - Structs -
// --------------------------------------

spAnimation :: struct {
// TODO(devon): asd
}

// TODO(devon): Can we change this to a distinct [4]c.float for swizzles?
spColor :: struct {
	r: c.float,
	g: c.float,
	b: c.float,
	a: c.float,
}

spEventData :: struct {
	name:        cstring,
	intValue:    c.int,
	floatValue:  c.float,
	stringValue: cstring,
	audioPath:   cstring,
	volume:      c.float,
	balance:     c.float,
}

spEvent :: struct {
	data: ^spEventData,
time: c.float,
intValue: c.int,
floatValue: c.float,
stringValue: cstring,
volume: c.float,
balance: c.float,
}

spAttachmentLoader :: struct {
		error1: cstring,
		error2: cstring,
		vtable: rawptr,
}

spAttachment :: struct {
		name: cstring,
		type: spAttachmentType,
		vtable: rawptr,
		refCount: c.int,
		attachmentLoader: ^spAttachmentLoader,
}

spBoneData :: struct {
index: c.int,
	name: cstring,
	parent: ^spBoneData,
	length: c.float,
	x, y: c.float,  
	rotation: c.float, 
	scaleX, scaleY: c.float,
	shearX, shearY: c.float,
	 transformMode: spTransformMode,
	skinRequired: c.int,
	color: spColor,
}

spBone :: struct {
// TODO(devon): asd
}

spBoundingBoxAttachment :: struct {
		super: spVertexAttachment,
		color: spColor,
}

spClippingAttachment :: struct {
		super: spVertexAttachment,
		endSlot: ^spSlotData,
		color: spColor,
}

spIkConstraint :: struct {
		data: ^spIkConstraintData,
		bonesCount: c.int,
		bones: [^]^spBone,
		target: ^spBone,
		bendDirection: c.int,
		compress: c.int,
		stretch: c.int,
		mix: c.float,
		softness: c.float,
		active: c.int,
}

spIkConstraintData :: struct {
		name: cstring,
		order: c.int,
		skinRequired: c.int,
		bonesCount: c.int,
		bones: [^]^spBoneData,
		target: ^spBoneData,
		bendDirection: c.int,
		compress: c.int,
		stretch: c.int,
		uniform: c.int,
		mix: c.float,
		softness: c.float,
}

spMeshAttachment :: struct {
		super: spVertexAttachment,

		rendererObject: rawptr,
		region: ^spTextureRegion,
		sequence: ^spSequence,

		path: cstring,

		regionUVs: [^]c.float,
		uvs: [^]c.float,

		trianglesCount: c.int,
		triangles: c.ushort,

		color: spColor,

		hullLength: c.int,

		parentMesh: ^spMeshAttachment,

		edgesCount: c.int,
		edges: [^]c.int,
		width, height: c.float,
}

spPathAttachment :: struct {
		super: spVertexAttachment,
		lengthsLength: c.int,
		lengths: [^]c.float,
		closed: c.int,
		constantSpeed: c.int,
		color: spColor,
}

spPathConstraint :: struct {
		data: ^spPathConstraintData,
		bonesCount: c.int,
		bones: [^]^spBone,
		target: ^spSlot,
		position: c.float,
		spacing: c.float,
		mixRotate: c.float,
		mixX, mixY: c.float,
		
		spacesCount: c.int,
		spaces: [^]c.float,

		positionsCount: c.int,
		positions: [^]c.float,

		worldCount: c.int,
		world: [^]c.float,

		curvesCount: c.int,
		curves: [^]c.float,

		lengthsCount: c.int,
		lengths: [^]c.float,

		segments: [10]c.float,

		active: c.int,
}

spPathConstraintData :: struct {
		name: cstring,
		order: c.int,
		skinRequired: c.int,
		bonesCount: c.int,
		bones: [^]^spBoneData,
		target: ^spSlotData,
		positionMode: spPositionMode,
		spacingMode: spSpacingMode,
		rotateMode: spRotateMode,
		offsetRotation: c.float,
		position: c.float,
		spacing: c.float,
		mixRotate: c.float,
		mixX, mixY: c.float,
}

spPointAttachment :: struct {
		super: spAttachment,
		x, y: c.float,
		rotation: c.float,
		color: spColor,
}

spPolygon :: struct {
		vertices: [^]c.float,
		count: c.int,
		capacity: c.int,
}


spRegionAttachment :: struct {
		super: spAttachment,
		path: cstring,
		x, y: c.float,
		scaleX, scaleY: c.float,
		rotation: c.float,
		width, height: c.float,
		color: spColor,
		rendererObjeckt: rawptr,
		region: ^spTextureRegion,
		sequence: ^spSequence,

		offset: [8]c.float,
		uvs: [8]c.float,
}

spSequence :: struct {
		id: c.int,
		start: c.int,
		digits: c.int,
		setupIndex: c.int,
		
		regions: ^spTextureRegionArray,
}

spSkeleton :: struct {
		data: ^spSkeletonData,

		bonesCount: c.int,
		bones: [^]^spBone,
		root: ^spBone,

		slotsCount: c.int,
		slots: [^]^spSlot,
		drawOrder: [^]^spSlot,

		ikConstraintsCount: c.int,
		ikConstraints: [^]^spIkConstraint,

		transformConstraintsCount: c.int,
		transformConstraints: [^]^spTransformConstraint,

		pathConstraintsCount: c.int,
		pathConstraints: [^]^spPathConstraint,

		skin: ^spSkin,
		color: spColor,
		scaleX, scaleY: c.float,
		x, y: c.float,
}

spSkeletonBinary :: struct {
		scale: c.float,
		attachmentLoader: ^spAttachmentLoader,
		error: cstring,
}

spSkeletonBounds :: struct {
		count: c.int,
		boundingBoxes: [^]^spBoundingBoxAttachment,
		polygons: [^]^spPolygon,
		minX, minY: c.float,
		maxX, maxY: c.float,
}

spSkeletonClipping :: struct {
		triangulator: ^spTriangulator,

		clippingPolygon	: ^spFloatArray,
		clipOutput		:  ^spFloatArray,
		clippedVertices	:  ^spFloatArray,
		clippedUVs		:  ^spFloatArray,
		clippedTriangles:  ^spUnsignedShortArray,

		scratch: ^spFloatArray,
		clipAttachment: ^spClippingAttachment,
		clippingPolygons: ^spArrayFloatArray,
}

spSkeletonData :: struct {
		version: cstring,
		hash: cstring,
		x, y: c.float,
		width, height: c.float,
		fps: c.float,
		imagesPath: cstring,
		audioPath: cstring,
		
		stringsCount: c.int,
		strings: [^]cstring,

		bonesCount: c.int,
		bones: [^]^spBoneData,

		slotsCount: c.int,
		slots: [^]^spSlotData,

		skinsCount: c.int,
		skins: [^]^spSkin,
		defaultSkin: ^spSkin,

		eventsCount: c.int,
		events: [^]^spEventData,

		animationsCount: c.int,
		animations: [^]^spAnimation,

		ikConstraintsCount: c.int,
		ikConstraints: [^]^spIkConstraintData,

		transformConstraintsCount: c.int,
		transformConstraints: [^]^spTransformConstraintData,

		pathConstraintsCount: c.int,
		pathConstraints: [^]^spPathConstraintData,
}

spSkeletonJson :: struct {
		scale: c.float,
		attachmentLoader: ^spAttachmentLoader,
		error: cstring,
}

spSkin :: struct {
		name: cstring,

		bones: ^spBoneDataArray,
		ikConstraints: ^spIkConstraintDataArray,
		transformConstraints: ^spTransformConstraintDataArray,
		pathConstraints: ^spPathConstraintDataArray,
}

spSkinEntry :: struct {
		slotIndex: c.int,
		name: cstring,
		attachment: ^spAttachment,
		next: ^spSkinEntry,
}

spSlot :: struct {
		data: ^spSlotData,
		bone: ^spBone,
		color: spColor,
		darkColor: ^spColor,
		attachment: ^spAttachment,
		attachmentState: c.int,
		deformCapacity: c.int,
		deformCount: c.int,
		deform: [^]c.float,
		sequenceIndex: c.int,
}

spSlotData :: struct {
		index: c.int,
		name: cstring,
		boneData: ^spBoneData,
		attachmentName: cstring,
		color: spColor,
		darkcolor: ^spColor,
		blendMode: spBlendMode,
}

spTextureRegion :: struct {
	rendererObject: rawptr,
	u, v:              c.float,
	u2, v2:             c.float,
	degrees:        c.int,
	offsetX, ossetY:        c.float,
	width, height:          c.int,
	originalWidth, originalHeight:  c.int,
}

spTransformConstraintData :: struct {
		name: cstring,
		order: c.int,
		skinRequired: c.int,
		bonesCount: c.int,
		bones: [^]^spBoneData,
		target: ^spBoneData,
		mixRotate: c.float,
		minX, minY: c.float,
		minScaleX, minScaleY: c.float,
		mixShearY: c.float,
		offsetRotation: c.float,
		offsetX, offsetY: c.float,
		offsetScaleX, offsetScaleY: c.float,
		offsetShearY: c.float,
		relative: c.int,
		local: c.int,
}

spTransformConstraint :: struct {
		data: ^spTransformConstraintData,
		bonesCount: c.int,
		bones: [^]^spBone,
		target: ^spBone,
		mixRotate: c.float,
		mixX, mixY: c.float,
		mixScaleX, mixScaleY: c.float,
		mixShearY: c.float,
		active: c.int,
}

spTriangulator :: struct {
		convexPolygons: ^spArrayFloatArray,
		convexPolygonsIndices: ^spArrayShortArray,

		indicesArray: ^spShortArray,
		isConcaveArray: ^spIntArray,
		triangles: ^spShortArray,

		polygonPool: ^spArrayFloatArray,
		polygonIndicesPool: ^spArrayShortArray,
}

spVertexAttachment :: struct {
		super: spAttachment,
		bonesCount: c.int,
		bones: [^]c.int,
		verticesCount: c.int,
		vertices: [^]c.float,
		worldVerticesLength: c.int,
		timelineAttachment: ^spAttachment,
		id: c.int,
}

// Arrays
spFloatArray :: struct {
		size: c.int,
		capacity: c.int,
		items: [^]c.float,
 }

spIntArray :: struct {
		size: c.int,
		capacity: c.int,
		items: [^]c.int,
}

spShortArray :: struct {
		size: c.int,
		capacity: c.int,
		items: [^]c.short,
}

spUnsignedShortArray :: struct {
		size: c.int,
		capacity: c.int,
		items: [^]c.ushort,
}

spArrayFloatArray :: struct {
		size: c.int,
		capacity: c.int,
		items: [^]^spFloatArray,
}

spArrayShortArray :: struct {
		size: c.int,
		capacity: c.int,
		items: [^]^spShortArray,
}

spBoneDataArray :: struct {
		size: c.int,
		capacity: c.int,
		items: [^]^spBoneData,
}

spIkConstraintDataArray :: struct {
		size: c.int,
		capacity: c.int,
		items: [^]^spIkConstraintData,
}

spTransformConstraintDataArray :: struct {
		size: c.int,
		capacity: c.int,
		items: [^]^spTransformConstraintData,
}

spPathConstraintDataArray :: struct {
		size: c.int,
		capacity: c.int,
		items: [^]^spPathConstraintData,
}

spTextureRegionArray :: struct {
		size: c.int,
		capacity: c.int,
		items: [^]^spTextureRegion,
}




// - Procedures -
// --------------------------------------


@(default_calling_convention = "c")
foreign lib {
	// [Color.h] ---
	spColor_create :: proc() -> ^spColor ---
	spColor_dispose :: proc(self: ^spColor) ---
	spColor_setFromFloats :: proc(color: ^spColor, r: c.float, g: c.float, b: c.float, a: c.float) ---


	// [EventData.h] ---
	spEventData_create :: proc(name: cstring) -> ^spEventData ---
	spEventData_dispose :: proc(self: ^spEventData) ---


}

// void _spAtlasPage_createTexture(spAtlasPage *self, const char *path);

// void _spAtlasPage_disposeTexture(spAtlasPage *self);

// char *_spUtil_readFile(const char *path, int *length);
