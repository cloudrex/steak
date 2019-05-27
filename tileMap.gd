extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var _tileset
const _tileIdGrass = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	print("TileMap ready")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_mouse_button_pressed(BUTTON_LEFT)):
		var mousePosition = get_global_mouse_position()
		var location = self.world_to_map(mousePosition)
		var cell = self.get_cell(location.x, location.y)
		
		if (cell != -1):
			print(self.tile_set.tile_get_name(cell))
		else:
			self.set_cell(location.x, location.y, _tileIdGrass)
