@tool
extends Control

#Based on 1.1.1
# from https://github.com/BOTLANNER/godot-gif/releases/tag/1.1.1
var _gif_manaher_names: PackedStringArray = [
	"GifManager",
	"GifToAnimatedTextureImportPlugin",
	"GifToSpriteFramesImportPlugin",
	"GifToSpriteFramesImportPlugin",
	"GifToSpriteFramesPlugin"
]
var mascots_paths: PackedStringArray = [
	"res://addons/godot_mascots/scenes/chicken.tscn",
	"res://addons/godot_mascots/scenes/clippy.tscn"
	
]
## Indicates if the project has [b]godotgif[/b] module installed, since this plugin doesn't
## provide that support 
var has_gif_manager: bool

var base_textures: Array[Texture2D] = [
	preload("res://addons/godot_mascots/assets/images/backgrounds/autumn/background-dark-large.png"),
	preload("res://addons/godot_mascots/assets/images/backgrounds/beach/background-dark-large.png"),
	preload("res://addons/godot_mascots/assets/images/backgrounds/castle/background-dark-large.png"),
	preload("res://addons/godot_mascots/assets/images/backgrounds/forest/background-dark-large.png"),
	preload("res://addons/godot_mascots/assets/images/backgrounds/winter/background-dark-large.png")
]
var extr_textures: Array[Texture2D] = [
	preload("res://addons/godot_mascots/assets/images/backgrounds/autumn/foreground-dark-large.png"),
	preload("res://addons/godot_mascots/assets/images/backgrounds/beach/foreground-dark-large.png"),
	preload("res://addons/godot_mascots/assets/images/backgrounds/castle/foreground-dark-large.png"),
	preload("res://addons/godot_mascots/assets/images/backgrounds/forest/foreground-dark-large.png"),
	preload("res://addons/godot_mascots/assets/images/backgrounds/winter/foreground-dark-large.png")
]

var mascot_stack: Array[Mascot]


func _init() -> void:
	for n: String in _gif_manaher_names:
		has_gif_manager = n in ClassDB.get_class_list()
		if not has_gif_manager:
			printerr("You need the plugin 'godotgif' in order to use some premade sprites!")
			break

func _ready() -> void:
	var normal: int = randi_range(0, base_textures.size()-1)
	
	$background/TextureRect.texture  = base_textures[normal]
	$background/TextureRect2.texture = extr_textures[normal]


func _on_add_pressed() -> void:
	
	if has_gif_manager:
		var selected: int = randi_range(0, mascots_paths.size()-1)
		var actual: Mascot = load(mascots_paths[selected]).instantiate()
		actual.position.x = 20
		actual.position.y = $ref.position.y-20
		add_child(actual)
		mascot_stack.append(actual)


func _on_delete_pressed() -> void:
	if mascot_stack.size() != 0:
		remove_child(mascot_stack[0])
		mascot_stack[0].free()
		mascot_stack.remove_at(0)
	else:
		print("There's no mascot to delete!")
