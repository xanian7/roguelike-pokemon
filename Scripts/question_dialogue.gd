extends Label

@onready var player_pokemon = %PlayerPokemon

func _process(_delta):
	var out_pokemon = player_pokemon.get_child(1)
	if out_pokemon.nickname:
		text = "What will \n" + str(out_pokemon.nickname) + " do?"
	else:
		text = "What will \n" + str(out_pokemon.pokemon_name) + " do?"
