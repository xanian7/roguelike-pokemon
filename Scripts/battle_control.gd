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
@onready var player_health_bar = $PlayerHealth/PlayerHealthBar
@onready var foe_health_bar = $FoeHealth/FoeHealthBar

var out_pokemon = null
var out_foe_pokemon = null

var rng = RandomNumberGenerator.new()

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
		out_foe_pokemon = GameManager.foe_pokemon.instantiate()
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

func start_round(attack, pokemon_change = null, item = null, run = null):
	options.visible = false
	attacks.visible = false
	if attack: 
		if out_foe_pokemon.current_speed > out_pokemon.current_speed:
			damage_pokemon(out_foe_pokemon, attack, out_pokemon)
			await get_tree().create_timer(1.0).timeout
			damage_pokemon(out_pokemon, attack, out_foe_pokemon)
		else:
			damage_pokemon(out_pokemon, attack, out_foe_pokemon)
			await get_tree().create_timer(1.0).timeout
			damage_pokemon(out_foe_pokemon, attack, out_pokemon)
	if pokemon_change:
		pass
	
	if item:
		pass
	
	if run: 
		pass
		
	options.visible = true
		
		
		
func get_foe_move():
	var moves = [out_foe_pokemon.move_slot_1,out_foe_pokemon.move_slot_2,out_foe_pokemon.move_slot_3,out_foe_pokemon.move_slot_4]
	var move = rng.randi_range(0, 3)
	
	while true:
		if moves[move]:
			return moves[move]
	
	
func damage_pokemon(attack_pokemon, move, hurt_pokemon):
	var targets = 1
	var PB = 1
	var weather = 1
	var glaive_rush = 1
	var critical = 1
	var random = rng.randi_range(85, 100) / 100.0
	
	var stab = 1
	for type in attack_pokemon.types:
		if type == move.type:
			stab = 1.5
	
	var a_s_stat = 0 
	var d_s_stat = 0
	if move.attack_type == "Physical":
		a_s_stat = attack_pokemon.current_attack
		d_s_stat = hurt_pokemon.current_defense
	else:
		a_s_stat = attack_pokemon.current_special_attack
		d_s_stat = hurt_pokemon.current_special_defense
	
	var type_effectiveness = move_effectiveness(move.type, hurt_pokemon.types)
	
	var burn = 1
	var other = 1
	var zmove = 1
	var terashield = 1
	
	var damage = floor(((((((2 * attack_pokemon.level)/2) + 2) * move.damage * (a_s_stat/d_s_stat)) / 50) + 2) * targets * PB * weather * glaive_rush * critical * random * stab * type_effectiveness * burn * other * zmove * terashield)
	print(damage)
	hurt_pokemon.current_hp -= damage
	print(hurt_pokemon.current_hp)
	update_health_ui()
		

func move_effectiveness(attack_type, foe_pokemon_types):
	var result = 1
	var effectiveness_dict = {"Normal": {"Normal": 1, "Fighting": 1, "Flying": 1, "Poison": 1, "Ground": 1, "Rock": 0.5, "Bug": 1, "Ghost": 0, "Steel": 0.5, "Fire": 1, "Water": 1, "Grass": 1, "Electric": 1, "Psychic": 1, "Ice": 1, "Dragon": 1, "Dark": 1, "Fairy": 1},
	"Fighting": {"Normal": 2, "Fighting": 1, "Flying": 0.5, "Poison": 0.5, "Ground": 1, "Rock": 2, "Bug": 0.5, "Ghost": 0, "Steel": 2, "Fire": 1, "Water": 1, "Grass": 1, "Electric": 1, "Psychic": 0.5, "Ice": 1, "Dragon": 1, "Dark": 2, "Fairy": 0.5},
	"Flying": {"Normal": 1, "Fighting": 2, "Flying": 1, "Poison": 1, "Ground": 1, "Rock": 0.5, "Bug": 2, "Ghost": 1, "Steel": 0.5, "Fire": 1, "Water": 1, "Grass": 2, "Electric": 0.5, "Psychic": 1, "Ice": 1, "Dragon": 1, "Dark": 1, "Fairy": 1}, 
	"Poison": {"Normal": 1, "Fighting": 1, "Flying": 1, "Poison": 0.5, "Ground": 0.5, "Rock": 0.5, "Bug": 1, "Ghost": 0.5, "Steel": 0, "Fire": 1, "Water": 1, "Grass": 2, "Electric": 1, "Psychic": 1, "Ice": 1, "Dragon": 1, "Dark": 1, "Fairy": 2},
	"Ground": {"Normal": 1, "Fighting": 1, "Flying": 0, "Poison": 2, "Ground": 1, "Rock": 2, "Bug": 0.5, "Ghost": 1, "Steel": 2, "Fire": 2, "Water": 1, "Grass": 0.5, "Electric": 2, "Psychic": 1, "Ice": 1, "Dragon": 1, "Dark": 1, "Fairy": 1},
	"Rock": {"Normal": 1, "Fighting": 0.5, "Flying": 2, "Poison": 1, "Ground": 0.5, "Rock": 1, "Bug": 2, "Ghost": 1, "Steel": 0.5, "Fire": 2, "Water": 1, "Grass": 1, "Electric": 1, "Psychic": 1, "Ice": 2, "Dragon": 1, "Dark": 1, "Fairy": 1},
	"Bug": {"Normal": 1, "Fighting": 0.5, "Flying": 0.5, "Poison": 0.5, "Ground": 1, "Rock": 1, "Bug": 1, "Ghost": 0.5, "Steel": 0.5, "Fire": 0.5, "Water": 1, "Grass": 2, "Electric": 1, "Psychic": 2, "Ice": 1, "Dragon": 1, "Dark": 2, "Fairy": 0.5},
	"Ghost": {"Normal": 0, "Fighting": 1, "Flying": 1, "Poison": 1, "Ground": 1, "Rock": 1, "Bug": 1, "Ghost": 2, "Steel": 1, "Fire": 1, "Water": 1, "Grass": 1, "Electric": 1, "Psychic": 2, "Ice": 1, "Dragon": 1, "Dark": 0.5, "Fairy": 1},
	"Steel": {"Normal": 1, "Fighting": 1, "Flying": 1, "Poison": 1, "Ground": 1, "Rock": 2, "Bug": 1, "Ghost": 1, "Steel": 0.5, "Fire": 0.5, "Water": 0.5, "Grass": 1, "Electric": 0.5, "Psychic": 1, "Ice": 2, "Dragon": 1, "Dark": 1, "Fairy": 2},
	"Fire": {"Normal": 1, "Fighting": 1, "Flying": 1, "Poison": 1, "Ground": 1, "Rock": 0.5, "Bug": 2, "Ghost": 1, "Steel": 2, "Fire": 0.5, "Water": 0.5, "Grass": 2, "Electric": 1, "Psychic": 1, "Ice": 2, "Dragon": 0.5, "Dark": 1, "Fairy": 1},
	"Water": {"Normal": 1, "Fighting": 1, "Flying": 1, "Poison": 1, "Ground": 2, "Rock": 2, "Bug": 1, "Ghost": 1, "Steel": 1, "Fire": 2, "Water": 0.5, "Grass": 0.5, "Electric": 1, "Psychic": 1, "Ice": 1, "Dragon": 0.5, "Dark": 1, "Fairy": 1},
	"Grass": {"Normal": 1, "Fighting": 1, "Flying": 0.5, "Poison": 0.5, "Ground": 2, "Rock": 2, "Bug": 0.5, "Ghost": 1, "Steel": 0.5, "Fire": 0.5, "Water": 2, "Grass": 0.5, "Electric": 1, "Psychic": 1, "Ice": 1, "Dragon": 0.5, "Dark": 1, "Fairy": 1},
	"Electric": {"Normal": 1, "Fighting": 1, "Flying": 2, "Poison": 1, "Ground": 0, "Rock": 1, "Bug": 1, "Ghost": 1, "Steel": 1, "Fire": 1, "Water": 2, "Grass": 0.5, "Electric": 0.5, "Psychic": 1, "Ice": 1, "Dragon": 0.5, "Dark": 1, "Fairy": 1},
	"Psychic": {"Normal": 1, "Fighting": 2, "Flying": 1, "Poison": 2, "Ground": 1, "Rock": 1, "Bug": 1, "Ghost": 1, "Steel": 0.5, "Fire": 1, "Water": 1, "Grass": 1, "Electric": 1, "Psychic": 0.5, "Ice": 1, "Dragon": 1, "Dark": 0, "Fairy": 1},
	"Ice": {"Normal": 1, "Fighting": 1, "Flying": 2, "Poison": 1, "Ground": 2, "Rock": 1, "Bug": 1, "Ghost": 1, "Steel": 0.5, "Fire": 0.5, "Water": 0.5, "Grass": 2, "Electric": 1, "Psychic": 1, "Ice": 0.5, "Dragon": 2, "Dark": 1, "Fairy": 1},
	"Dragon": {"Normal": 1, "Fighting": 1, "Flying": 1, "Poison": 1, "Ground": 1, "Rock": 1, "Bug": 1, "Ghost": 1, "Steel": 0.5, "Fire": 1, "Water": 1, "Grass": 1, "Electric": 1, "Psychic": 1, "Ice": 1, "Dragon": 2, "Dark": 1, "Fairy": 0},
	"Dark": {"Normal": 1, "Fighting": 0.5, "Flying": 1, "Poison": 1, "Ground": 1, "Rock": 1, "Bug": 1, "Ghost": 2, "Steel": 1, "Fire": 1, "Water": 1, "Grass": 1, "Electric": 1, "Psychic": 2, "Ice": 1, "Dragon": 1, "Dark": 0.5, "Fairy": 0.5},
	"Fairy": {"Normal": 1, "Fighting": 2, "Flying": 1, "Poison": 0.5, "Ground": 1, "Rock": 1, "Bug": 1, "Ghost": 1, "Steel": 0.5, "Fire": 0.5, "Water": 1, "Grass": 1, "Electric": 1, "Psychic": 1, "Ice": 1, "Dragon": 2, "Dark": 2, "Fairy": 1}}
	
	for type in foe_pokemon_types:
		var type_effectiveness = effectiveness_dict[attack_type]
		result *= type_effectiveness[type]
	
	return result
	
func update_health_ui():
	if player_health_bar:
		player_health_bar.max_value = out_pokemon.hp
		player_health_bar.value = out_pokemon.current_hp
	
	if foe_health_bar:
		foe_health_bar.max_value = out_foe_pokemon.hp
		foe_health_bar.value = out_foe_pokemon.current_hp


func _on_fight_pressed():
	if attacks:
		attacks.visible = true
		if options:
			options.visible = false
		
	


func _on_slot_1_pressed():
	start_round(out_pokemon.move_slot_1.instantiate())


func _on_slot_2_pressed():
	start_round(out_pokemon.move_slot_2.instantiate())


func _on_slot_3_pressed():
	start_round(out_pokemon.move_slot_3.instantiate())


func _on_slot_4_pressed():
	start_round(out_pokemon.move_slot_4.instantiate())
