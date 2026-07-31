# export_tilemap_to_json.gd
extends Node

@export var tilemap_path: NodePath
@export var output_file: String = "user://map.json"

func _ready():
	_export_tilemap()

func _export_tilemap():
	var tilemap: TileMap = get_node(tilemap_path)

	var exported := {
		"tilemap_format_version": 1,
		"tilemap_cell_size": tilemap.tile_set.tile_size if tilemap.tile_set else null,
		"layers": {}
	}

	# In Godot 4, TileMap can have multiple layers.
	# We'll export all layers, and for each layer all used cells.
	for layer in tilemap.get_layers_count():
		var layer_key := str(layer)
		exported["layers"][layer_key] = []

		for cell in tilemap.get_used_cells(layer):
			# cell is the cell coordinate (Vector2i in 2D tilemaps)
			var source_id := tilemap.get_cell_source_id(layer, cell)
			var atlas_coords := tilemap.get_cell_atlas_coords(layer, cell)
			var alternative_tile := tilemap.get_cell_alternative_tile(layer, cell)

			# If your TileMap is empty at some cells, you can skip when source_id == -1
			if source_id == -1:
				continue

			exported["layers"][layer_key].append({
				"cell": [cell.x, cell.y],
				"source_id": source_id,
				"atlas_coords": [atlas_coords.x, atlas_coords.y],
				"alternative_tile": alternative_tile
			})

	var file := FileAccess.open(output_file, FileAccess.WRITE)
	if file == null:
		push_error("Could not open file for writing: %s" % output_file)
		return

	var json_text := JSON.stringify(exported, "  ") # pretty indent
	file.store_string(json_text)
	file.close()

	print("Exported tilemap to: ", output_file)
