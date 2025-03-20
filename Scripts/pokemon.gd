extends Node2D

@onready var sprite_2d = $Sprite2D

@export var pokemon_name: String
@export var nickname: String
@export var is_in_party: bool

#Sprites
@export var back_sprite: CompressedTexture2D
@export var front_sprite: CompressedTexture2D
@export var shiny_back_sprite: CompressedTexture2D
@export var shiny_front_sprite: CompressedTexture2D
@export var bag_sprite: CompressedTexture2D
@export var shiny_bag_sprite: CompressedTexture2D

#Levels
@export var level: int
@export var evolution_level: int
@export var evolution: Node2D
@export var types: Array[String]

#Moves
@export var move_slot_1: PackedScene
@export var move_slot_2: PackedScene
@export var move_slot_3: PackedScene
@export var move_slot_4: PackedScene

#Base Stats
@export var hp_base: int
@export var attack_base: int
@export var defense_base: int
@export var special_attack_base: int
@export var special_defense_base: int
@export var speed_base: int

#Individual Values
@export var hp_iv: int
@export var attack_iv: int
@export var defense_iv: int
@export var special_attack_iv: int
@export var special_defense_iv: int
@export var speed_iv: int

#Effort Values
@export var hp_ev: int
@export var attack_ev: int
@export var defense_ev: int
@export var special_attack_ev: int
@export var special_defense_ev: int
@export var speed_ev: int

#Actual Stat Values (calculated using base/iv/ev)
var hp: int
var attack: int
var defense: int
var special_attack: int
var special_defense: int
var speed: int

#Stat Values to be Used in Battle
var current_hp: int
var current_attack: int
var current_defense: int
var current_special_attack: int
var current_special_defense: int
var current_speed: int



func _ready():
	set_sprite()
	calculate_stats()

func set_sprite():
	if is_in_party:
		sprite_2d.texture = back_sprite
	else:
		sprite_2d.texture = front_sprite
		
func calculate_stats():
	hp = floor(0.01 * (2 * hp_base + hp_iv + floor(0.25 * hp_ev)) * level) + level + 10
	attack = floor(0.01 * (2 * attack_base + attack_iv + floor(0.25 * attack_ev)) * level) + 5
	defense = floor(0.01 * (2 * defense_base + defense_iv + floor(0.25 * defense_ev)) * level) + 5
	special_attack = floor(0.01 * (2 * special_attack_base + special_attack_iv + floor(0.25 * special_attack_ev)) * level) + 5
	special_defense = floor(0.01 * (2 * special_defense_base + special_defense_iv + floor(0.25 * special_defense_ev)) * level) + 5
	speed = floor(0.01 * (2 * speed_base + speed_iv + floor(0.25 * speed_ev)) * level) + 5
	
	current_hp = hp
	current_attack = attack
	current_defense = defense
	current_special_attack = special_attack
	current_special_defense = special_defense
	current_speed = speed
