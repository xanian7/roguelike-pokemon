extends Control

@onready var player_pokemon = %PlayerPokemon
@onready var foe_pokemon = %FoePokemon
@onready var player_sprite_location = %PlayerSpriteLocation
@onready var foe_sprite_location = %FoeSpriteLocation
@onready var attacks = $Attacks
@onready var options = $Options
@onready var slot_1 = $Attacks/Slot1
@onready var slot_2 = $Attacks/Slot2
@onready var slot_3 = $Attacks/Slot3
@onready var slot_4 = $Attacks/Slot4

var out_pokemon = null


func _ready():
	game_start()

func game_start():
	if player_pokemon and foe_pokemon:
		spawn_pokemon()

func spawn_pokemon():
	if Player.pokemon_1:
		out_pokemon = Player.pokemon_1.instantiate()
		out_pokemon.is_in_party = true
		player_pokemon.add_child(out_pokemon)
		
		if player_sprite_location:
			out_pokemon.position = player_sprite_location.position
			
	if GameManager.foe_pokemon:
		var out_foe_pokemon = GameManager.foe_pokemon.instantiate()
		foe_pokemon.add_child(out_foe_pokemon)
		
		if foe_sprite_location:
			out_foe_pokemon.position = foe_sprite_location.position
			
func _process(_delta):
	set_moves()
			
func set_moves():
	if out_pokemon:
		if out_pokemon.move_slot_1:
			slot_1.visible = true
			var move = out_pokemon.move_slot_1.instantiate()
			slot_1.texture_normal = move.button_texture
			slot_1.texture_hover = move.pressed_button_texture
			slot_1.texture_pressed = move.pressed_button_texture
			if slot_1.get_child(0):
				var label = slot_1.get_child(0)
				label.text = move.move_name
		else: 
			slot_1.visible = false
			
		if out_pokemon.move_slot_2:
			slot_2.visible = true
			var move = out_pokemon.move_slot_2.instantiate()
			slot_2.texture_normal = move.button_texture
			slot_2.texture_hover = move.pressed_button_texture
			slot_2.texture_pressed = move.pressed_button_texture
			if slot_2.get_child(0):
				var label = slot_2.get_child(0)
				label.text = move.move_name
		else: 
			slot_2.visible = false
			
		if out_pokemon.move_slot_3:
			slot_3.visible = true
			var move = out_pokemon.move_slot_3.instantiate()
			slot_3.texture_normal = move.button_texture
			slot_3.texture_hover = move.pressed_button_texture
			slot_3.texture_pressed = move.pressed_button_texture
			if slot_3.get_child(0):
				var label = slot_3.get_child(0)
				label.text = move.move_name
		else: 
			slot_3.visible = false
			
		if out_pokemon.move_slot_4:
			slot_4.visible = true
			var move = out_pokemon.move_slot_4.instantiate()
			slot_4.texture_normal = move.button_texture
			slot_4.texture_hover = move.pressed_button_texture
			slot_4.texture_pressed = move.pressed_button_texture
			if slot_4.get_child(0):
				var label = slot_4.get_child(0)
				label.text = move.move_name
		else: 
			slot_4.visible = false
		
		


func _on_fight_pressed():
	if attacks:
		attacks.visible = true
		if options:
			options.visible = false
		
	
