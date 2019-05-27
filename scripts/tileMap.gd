extends TileMap

enum Tile {STONE = 0, COPPER = 1, GRASS = 2}

const THRESHOLD = 0.15
const RADIUS = 8


var rarity = {Tile.GRASS: 15, Tile.STONE: 5, Tile.COPPER: 80}
var tiles = [Tile.GRASS, Tile.STONE, Tile.COPPER]
var tileShortcuts = [KEY_1, KEY_2, KEY_3]
var tileShortcutCount = tileShortcuts.size()
var activeTile = tiles[0]
var noise;

func _ready():
	# Create a new simplex noise field.
	noise = OpenSimplexNoise.new();

	noise.seed = randi()
	noise.octaves = 8
	noise.period = 11.0
	noise.persistence = 0.2
	
	# Inform the developer.
	print("TileMap ready")

# Choose a block based on noise value.
func getNextTile(noise):
	if noise > THRESHOLD:
		return tiles[1]
	else:
		return tiles[0]


func generate(x, y):
	x = x / 16
	y = y / 16
	# Column.
	for i in range(-RADIUS, RADIUS + 1):
		for j in range(-RADIUS, RADIUS + 1):
			var xnoise = x + i / 2
			var ynoise = y + j / 2
			self.set_cellv(Vector2(x + i, y + j), getNextTile(noise.get_noise_2d(xnoise, ynoise)))

	print("Terrain generation completed")

# Returns the mouse cell location.
func getMouseLocation():
	var mousePosition = get_global_mouse_position()

	return self.world_to_map(mousePosition)

# Get the tile ID of the cell at the mouse location.
func getMouseCell():
	return self.get_cellv(self.getMouseLocation())

func getCellAt(position):
	return self.get_cellv(self.world_to_map(position))

func _process(delta):
	# Retrieve the mouse cell location.
	var location = self.getMouseLocation()

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
