package spine_raylib

import cc "core:c"
import fmt "core:fmt"

import os "odin_spine:core"

import rl "vendor:raylib"

SP_DRAW_DOUBLE_FACED :: #config(SP_DRAW_DOUBLE_FACED, false)
SP_RENDER_WIREFRAME :: #config(SP_RENDER_WIREFRAME, false)
SP_LAYER_SPACING_BASE :: #config(SP_LAYER_SPACING_BASE, 0)
SP_LAYER_SPACING :: #config(SP_LAYER_SPACING, 0)

MAX_TEXTURES :: 10
textures: [^]rl.Texture2D = raw_data(&[MAX_TEXTURES]rl.Texture2D{})
texture_index := 0
anti_z_index := SP_LAYER_SPACING_BASE
MAX_VERTICES_PER_ATTACHMENT :: 2048
world_vertices_positions := raw_data(&[MAX_VERTICES_PER_ATTACHMENT]cc.float{})

vertices := raw_data(&[MAX_VERTICES_PER_ATTACHMENT]os.Vertex{})
VERTEX_ORDER_NORMAL: [^]cc.int = raw_data(&[4]cc.int{0, 1, 2, 4})
VERTEX_ORDER_INVERSE: [^]cc.int = raw_data(&[4]cc.int{4, 2, 1, 0})


texture_2d_create :: proc(path: cstring) -> ^rl.Texture2D {
	textures[texture_index] = rl.LoadTexture(path)
	t := &textures[texture_index]

	rl.SetTextureFilter(t^, rl.TextureFilter.BILINEAR)
	texture_index += 1

	return t
}

texture_2d_destroy :: proc() {
	for texture_index > 0 {
		rl.UnloadTexture(textures[texture_index])
		texture_index -= 1
	}
}

@(export)
_spAtlasPage_createTexture :: proc(self: ^os.spAtlasPage, path: cstring) {

	t: ^rl.Texture2D = texture_2d_create(path)

	self.rendererObject = t
	self.width = t.width
	self.height = t.height
}

@(export)
_spAtlasPage_disposeTexture :: proc "c" (self: ^os.spAtlasPage) {
	if self.rendererObject == nil {return}

	t := cast(^rl.Texture2D)self.rendererObject
	rl.UnloadTexture(t^)
}

add_vertex :: proc(
	x: cc.float,
	y: cc.float,
	u: cc.float,
	v: cc.float,
	r: cc.float,
	g: cc.float,
	b: cc.float,
	a: cc.float,
	index: ^cc.int,
) {
	vertex: ^os.Vertex = &vertices[index^]
	vertex.x = x
	vertex.y = y
	vertex.u = u
	vertex.v = v
	vertex.r = r
	vertex.g = g
	vertex.b = b
	vertex.a = a
	index^ += 1

}


@(private = "file")
draw_region :: proc(
	vertices: [^]os.Vertex,
	texture: ^rl.Texture,
	position: rl.Vector3,
	vertex_order: [^]cc.int,
) {
	using rl
	using os

	vertex := Vertex{}

	rlSetTexture(texture.id)
	defer rlSetTexture(0)

	rlPushMatrix()
	defer rlPopMatrix()
	// <
	rlBegin(RL_QUADS)
	rlNormal3f(0.0, 0.0, 1.0)
	for i: cc.int = 0; i < 4; i += 1 {
		vertex = vertices[vertex_order[i]]
		rlTexCoord2f(vertex.u, vertex.v)
		rlColor4f(vertex.r, vertex.g, vertex.b, vertex.a)
		rlVertex3f(
			position.x + vertex.x,
			position.y + vertex.y,
			position.z + cast(f32)anti_z_index,
		)
	}
	rlEnd()
	// />

	when SP_DRAW_DOUBLE_FACED {
		// <
		rlBegin(RL_QUADS)
		rlNormal3f(0.0, 0.0, 1.0)
		for i: cc.int = 3; i >= 0; i -= 1 {
			vertex = vertices[vertex_order[i]]
			rlTexCoord2f(vertex.u, vertex.v)
			rlColor4f(vertex.r, vertex.g, vertex.b, vertex.a)
			rlVertex3f(
				position.x + vertex.x,
				position.y + vertex.y,
				position.z - cast(f32)anti_z_index,
			)
		}
		rlEnd()
		// />
	}

}

@(private = "file")
draw_mesh :: proc(
	vertices: [^]os.Vertex,
	start: cc.int,
	count: cc.int,
	texture: ^rl.Texture,
	position: rl.Vector3,
	vertex_order: [^]cc.int,
) {
	using rl
	using os

	vertex := Vertex{}

	rlPushMatrix()
	defer rlPopMatrix()

	for vertexIndex: cc.int = start; vertexIndex < count; vertexIndex += 3 {
		rlSetTexture(texture.id)

		// >
		rlBegin(RL_QUADS)

		i: cc.int
		for i = 2; i > -1; i -= 1 {
			vertex = vertices[vertexIndex + i]
			rlTexCoord2f(vertex.u, vertex.v)
			rlColor4f(vertex.r, vertex.g, vertex.b, vertex.a)
			rlVertex3f(
				position.x + vertex.x,
				position.y + vertex.y,
				position.z + cast(f32)anti_z_index,
			)
		}

		rlVertex3f(
			position.x + vertex.x,
			position.y + vertex.y,
			position.z + cast(f32)anti_z_index,
		)

		rlEnd()
		// />
		when SP_DRAW_DOUBLE_FACED {
			fmt.errorln(
				"Doubled sided not supported for mesh based spine files\n",
			)

			return
		}

		when SP_RENDER_WIREFRAME {
			DrawTriangleLines(
				(Vector2) {
					vertices[vertexIndex].x + position.x,
					vertices[vertexIndex].y + position.y,
				},
				(Vector2) {
					vertices[vertexIndex + 1].x + position.x,
					vertices[vertexIndex + 1].y + position.y,
				},
				(Vector2) {
					vertices[vertexIndex + 2].x + position.x,
					vertices[vertexIndex + 2].y + position.y,
				},
				vertexIndex == 0 ? RED : GREEN,
			)
		}

	}

	rlSetTexture(0)
}


draw_skeleton :: proc(
	skeleton: ^os.spSkeleton,
	position: rl.Vector3,
	PMA: cc.bool,
) {
	using rl
	using os

	blend_mode: cc.int = 4 //This mode doesnt exist
	vertex_order: [^]cc.int =
		(skeleton.scaleX * skeleton.scaleY < 0) \
		? VERTEX_ORDER_NORMAL \
		: VERTEX_ORDER_INVERSE
	// For each slot in the draw order array of the skeleton
	anti_z_index = SP_LAYER_SPACING_BASE

	// TODO(devon):  Might need start at 1
	for i: cc.int = 0; i < skeleton.slotsCount; i += 1 {
		anti_z_index -= SP_LAYER_SPACING
		slot: ^spSlot = skeleton.drawOrder[i]

		// Fetch the currently active attachment, continue
		// with the next slot in the draw order if no
		// attachment is active on the slot
		attachment: ^spAttachment = slot.attachment
		if attachment == nil {continue}

		// Fill the vertices array depending on the type of attachment
		texture: ^Texture = nil
		vertexIndex: cc.int = 0
		if (attachment.type == .SP_ATTACHMENT_REGION) {
			// Cast to an spRegionAttachment so we can get the rendererObject
			// and compute the world vertices
			regionAttachment: ^spRegionAttachment = cast(^spRegionAttachment)attachment

			// Calculate the tinting color based on the skeleton's color
			// and the slot's color. Each color channel is given in the
			// range [0-1], you may have to multiply by 255 and cast to
			// and int if your engine uses integer ranges for color channels.
			tintA: cc.float =
				skeleton.color.a * slot.color.a * regionAttachment.color.a
			alpha: cc.float = PMA ? tintA : 1
			tintR: cc.float =
				skeleton.color.r *
				slot.color.r *
				regionAttachment.color.r *
				alpha
			tintG: cc.float =
				skeleton.color.g *
				slot.color.g *
				regionAttachment.color.g *
				alpha
			tintB: cc.float =
				skeleton.color.b *
				slot.color.b *
				regionAttachment.color.b *
				alpha

			// Our engine specific Texture is stored in the spAtlasRegion which was
			// assigned to the attachment on load. It represents the texture atlas
			// page that contains the image the region attachment is mapped to
			texture =
			cast(^Texture)(cast(^spAtlasRegion)regionAttachment.rendererObject).page.rendererObject

			// Computed the world vertices positions for the 4 vertices that make up
			// the rectangular region attachment. This assumes the world transform of the
			// bone to which the slot (and hence attachment) is attached has been calculated
			// before rendering via spSkeleton_updateWorldTransform
			spRegionAttachment_computeWorldVertices(
				regionAttachment,
				slot,
				world_vertices_positions,
				0,
				2,
			)

			// Create 2 triangles, with 3 vertices each from the region's
			// world vertex positions and its UV coordinates (in the range [0-1]).
			add_vertex(
				world_vertices_positions[0],
				world_vertices_positions[1],
				regionAttachment.uvs[0],
				regionAttachment.uvs[1],
				tintR,
				tintG,
				tintB,
				tintA,
				&vertexIndex,
			)

			add_vertex(
				world_vertices_positions[2],
				world_vertices_positions[3],
				regionAttachment.uvs[2],
				regionAttachment.uvs[3],
				tintR,
				tintG,
				tintB,
				tintA,
				&vertexIndex,
			)

			add_vertex(
				world_vertices_positions[4],
				world_vertices_positions[5],
				regionAttachment.uvs[4],
				regionAttachment.uvs[5],
				tintR,
				tintG,
				tintB,
				tintA,
				&vertexIndex,
			)

			add_vertex(
				world_vertices_positions[4],
				world_vertices_positions[5],
				regionAttachment.uvs[4],
				regionAttachment.uvs[5],
				tintR,
				tintG,
				tintB,
				tintA,
				&vertexIndex,
			)

			add_vertex(
				world_vertices_positions[6],
				world_vertices_positions[7],
				regionAttachment.uvs[6],
				regionAttachment.uvs[7],
				tintR,
				tintG,
				tintB,
				tintA,
				&vertexIndex,
			)

			add_vertex(
				world_vertices_positions[0],
				world_vertices_positions[1],
				regionAttachment.uvs[0],
				regionAttachment.uvs[1],
				tintR,
				tintG,
				tintB,
				tintA,
				&vertexIndex,
			)

			if (cast(i32)slot.data.blendMode != blend_mode) {
				EndBlendMode()
				blend_mode = cast(i32)slot.data.blendMode

				switch blend_mode {
				case 1:
					//Additive
					rlSetBlendFactors(
						PMA ? RL_ONE : RL_SRC_ALPHA,
						RL_ONE,
						RL_FUNC_ADD,
					)
				case 2:
					//Multiply
					rlSetBlendFactors(
						RL_DST_COLOR,
						RL_ONE_MINUS_SRC_ALPHA,
						RL_FUNC_ADD,
					)
				case 3:
					//Screen
					rlSetBlendFactors(
						RL_ONE,
						RL_ONE_MINUS_SRC_COLOR,
						RL_FUNC_ADD,
					)
				case:
					// Normal
					rlSetBlendFactors(
						PMA ? RL_ONE : RL_SRC_ALPHA,
						RL_ONE_MINUS_SRC_ALPHA,
						RL_FUNC_ADD,
					)
				}

				BeginBlendMode(BlendMode.CUSTOM)
			}

			draw_region(vertices, texture, position, vertex_order)
		} else if attachment.type == .SP_ATTACHMENT_MESH {
			// Cast to an spMeshAttachment so we can get the rendererObject
			// and compute the world vertices
			mesh: ^spMeshAttachment = cast(^spMeshAttachment)attachment

			// Check the number of vertices in the mesh attachment. If it is bigger
			// than our scratch buffer, we don't render the mesh. We do this here
			// for simplicity, in production you want to reallocate the scratch buffer
			// to fit the mesh.
			if mesh.super.worldVerticesLength >
			   MAX_VERTICES_PER_ATTACHMENT {continue}

			tintA: cc.float = skeleton.color.a * slot.color.a * mesh.color.a
			alpha: cc.float = PMA ? tintA : 1
			tintR: cc.float =
				skeleton.color.r * slot.color.r * mesh.color.r * alpha
			tintG: cc.float =
				skeleton.color.g * slot.color.g * mesh.color.g * alpha
			tintB: cc.float =
				skeleton.color.b * slot.color.b * mesh.color.b * alpha

			// Our engine specific Texture is stored in the spAtlasRegion which was
			// assigned to the attachment on load. It represents the texture atlas
			// page that contains the image the mesh attachment is mapped to
			texture =
			cast(^Texture)(cast(^spAtlasRegion)mesh.rendererObject).page.rendererObject

			// Computed the world vertices positions for the vertices that make up
			// the mesh attachment. This assumes the world transform of the
			// bone to which the slot (and hence attachment) is attached has been calculated
			// before rendering via spSkeleton_updateWorldTransform
			spVertexAttachment_computeWorldVertices(
				&mesh.super, // SUPER(mesh),
				slot,
				0,
				mesh.super.worldVerticesLength,
				world_vertices_positions,
				0,
				2,
			)

			// Mesh attachments use an array of vertices, and an array of indices to define which
			// 3 vertices make up each triangle. We loop through all triangle indices
			// and simply emit a vertex for each triangle's vertex.
			// TODO(Maybe start at 1)
			for j: cc.int = 0; j < mesh.trianglesCount; j += 1 {
				// TODO: (Check cast)
				index: cc.int = cast(i32)mesh.triangles[j] << 1
				add_vertex(
					world_vertices_positions[index],
					world_vertices_positions[index + 1],
					mesh.uvs[index],
					mesh.uvs[index + 1],
					tintR,
					tintG,
					tintB,
					tintA,
					&vertexIndex,
				)
			}

			if (cast(i32)slot.data.blendMode != blend_mode) {
				EndBlendMode()
				blend_mode = cast(i32)slot.data.blendMode

				switch blend_mode {
				case 1:
					//Additive
					rlSetBlendFactors(
						PMA ? RL_ONE : RL_SRC_ALPHA,
						RL_ONE,
						RL_FUNC_ADD,
					)
				case 2:
					//Multiply
					rlSetBlendFactors(
						RL_DST_COLOR,
						RL_ONE_MINUS_SRC_ALPHA,
						RL_FUNC_ADD,
					)
				case 3:
					//Screen
					rlSetBlendFactors(
						RL_ONE,
						RL_ONE_MINUS_SRC_COLOR,
						RL_FUNC_ADD,
					)
				case:
					// Normal
					rlSetBlendFactors(
						PMA ? RL_ONE : RL_SRC_ALPHA,
						RL_ONE_MINUS_SRC_ALPHA,
						RL_FUNC_ADD,
					)
				}

				BeginBlendMode(BlendMode.CUSTOM)
			}
			//             // Draw the mesh we created for the attachment
			draw_mesh(
				vertices,
				0,
				vertexIndex,
				texture,
				position,
				vertex_order,
			)
		}
	}

	EndBlendMode() //Exit out
}
