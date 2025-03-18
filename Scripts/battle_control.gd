extends Control

@onready var player_pokemon = %PlayerPokemon
@onready var foe_pokemon = %FoePokemon
@onready var player_sprite_location = %PlayerSpriteLocation
@onready var foe_sprite_location = %FoeSpriteLocation


func _ready():
	game_start()

func game_start():
	if player_pokemon and foe_pokemon:
		spawn_pokemon()

func spawn_pokemon():
	if Player.pokemon_1:
		var out_pokemon = Player.pokemon_1.instantiate()
		player_pokemon.add_child(out_pokemon)
		
		if player_sprite_location:
			out_pokemon.position = player_sprite_location.position
		
		
