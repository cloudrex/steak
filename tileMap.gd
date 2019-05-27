extends TileMap

enum Tile {STONE = 0, COPPER = 1, GRASS = 2}

var rarity = {Tile.GRASS: 15, Tile.STONE: 5, Tile.COPPER: 80}
var tiles = [Tile.GRASS, Tile.STONE, Tile.COPPER]

func _ready():
	generate()
	print("TileMap ready")
	
	
func getNextTile():
	# Generate a random number from 1-100.
	var pick = randi() % 100 + 1
	
	# Create the resulting tile buffer.
	var result = tiles[0]
	
	for tile in tiles:
		if (pick >= rarity[tile]):
			result = tile
			
			break
			
	return result
	
func generate():
	var start = Vector2(-16, -16)
	var end = Vector2(16, 16)
	var buffer = start
	
	# Column.
	while (buffer.x != end.x):
		self.set_cellv(buffer, getNextTile())
		buffer.x += 1
		
		# Row.
		while (buffer.y != end.y):
			self.set_cellv(buffer, getNextTile())
			buffer.y += 1
		
		# Reset row counter.
		buffer.y = start.y
		
	print("Terrain generation completed")

func _process(delta):
	if (Input.is_mouse_button_pressed(BUTTON_LEFT)):
		var mousePosition = get_global_mouse_position()
		var location = self.world_to_map(mousePosition)
		var cell = self.get_cell(location.x, location.y)
		
		if (cell == -1):
			print("Set cell at: (" + str(location.x) + ", " + str(location.y) + ")")
			self.set_cell(location.x, location.y, Tile.GRASS)
