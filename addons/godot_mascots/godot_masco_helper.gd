class_name GodotMascotHelper


static func get_gif_frames(from: SpriteFrames) -> Array[Texture2D]:
	var final: Array[Texture2D]
	for n: int in range(0, from.get_frame_count("gif")):
		final.append(
			from.get_frame_texture("gif", n)
		)
	return final

static func add_textures(init: SpriteFrames, from: SpriteFrames, anim: String):
	if init.has_animation(anim):
		init.remove_animation(anim)
	init.add_animation(anim)
	for texture: Texture2D in get_gif_frames(from):
		init.add_frame(anim, texture)
	
	
