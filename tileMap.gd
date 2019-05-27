extends TileMap

const _tileIdGrass = 2

func _ready():
	print("TileMap ready")

func _process(delta):
	if (Input.is_mouse_button_pressed(BUTTON_LEFT)):
		var mousePosition = get_global_mouse_position()
		var location = self.world_to_map(mousePosition)
		var cell = self.get_cell(location.x, location.y)
		
		if (cell != -1):
			print(self.tile_set.tile_get_name(cell))
		else:
			self.set_cell(location.x, location.y, _tileIdGrass)
