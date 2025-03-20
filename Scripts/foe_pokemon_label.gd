extends Label

@onready var foe_pokemon = %FoePokemon

func _process(_delta):
	var out_pokemon = foe_pokemon.get_child(1)
	if out_pokemon.nickname:
		text = str(out_pokemon.nickname)
	else:
		text = str(out_pokemon.pokemon_name)
