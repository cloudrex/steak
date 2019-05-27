extends TileMap

enum Tile {STONE = 0, COPPER = 1, GRASS = 2}

var rarity = {Tile.GRASS: 15, Tile.STONE: 5, Tile.COPPER: 80}
var tiles = [Tile.GRASS, Tile.STONE, Tile.COPPER]
var tileShortcuts = [KEY_1, KEY_2, KEY_3]
var tileShortcutCount = tileShortcuts.size()
var activeTile = tiles[0]

func _ready():
	# Invoke terrain generation function.
	generate()
	
	# Inform the developer.
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

func getMouseLocation():
	var mousePosition = get_global_mouse_position()
	
	return self.world_to_map(mousePosition)
	
func getMouseCell():
	return self.get_cellv(getMouseLocation())

func _process(delta):
	# Retrieve the mouse cell location.
	var location = getMouseLocation()
	
	# Set tile.
	for i in range(tileShortcutCount):
		var key = tileShortcuts[i]
		
		if (Input.is_key_pressed(key)):
			activeTile = tiles[i]
	
	# Add tile.
	if (Input.is_mouse_button_pressed(BUTTON_LEFT)):		
		self.set_cellv(location, activeTile)
	# Remove tile.
	elif (Input.is_mouse_button_pressed(BUTTON_RIGHT)):
		self.set_cellv(location, -1)
