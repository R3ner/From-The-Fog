# Schedule our timed functions.
schedule function lunareclipse.watching:main/timed_ticks/1_second 1s
schedule function lunareclipse.watching:main/timed_ticks/5_minutes 300s

# Create a team for the door ghost that can help remove collision.
team add watching.door_ghost
team modify watching.door_ghost collisionRule never

# Set the commandModificationBlockLimit to max so it doesn't interfere with other packs. - This is used for large /fill commands.
gamerule minecraft:max_block_modifications 999999999
# Store the block tag that's used for shrine checking this is used for checks later.
data modify storage lunareclipse.watching:global_values shrine_block_tag set value "minecraft:fire"

# Create the needed scoreboard objectives.
scoreboard objectives add watching.animations dummy
scoreboard objectives add watching.global_values dummy
scoreboard objectives add watching.raycast dummy
scoreboard objectives add watching.player_time minecraft.custom:minecraft.play_time
scoreboard objectives add watching.time_played dummy

# Set the default config values.
function lunareclipse.watching:config/initialize_defaults

# Setup the layout of the config. 
function lunareclipse.watching:config/config_layout

# Setup the information about each skin.
function lunareclipse.watching:sightings/skin_library/define_skins

# (personal addition).
# Initialize show_load_message to 1 (enabled) if it is not set yet (doesn't match 0 or 1).
execute unless score show_load_message watching.global_values matches 0..1 run scoreboard players set show_load_message watching.global_values 1

# Print successful load debug message only if not disabled and a player is present (manual /reload).
execute if entity @a unless score show_load_message watching.global_values matches 0 run tellraw @a [{"text":"[","color":"yellow"},{"text":"From The Fog","color":"dark_purple"},{"text":"] ","color":"yellow"},{"text":"v1.3-26.1.2 ","color":"white"},{"translate":"from_the_fog.message.loaded","color":"green"}]

# (click_event y command)
execute if entity @a unless score show_load_message watching.global_values matches 0 run tellraw @a [{"text":" ↳ ","color":"light_purple"},{"translate":"from_the_fog.message.disable_load","color":"aqua","bold":true,"click_event":{"action":"run_command","command":"scoreboard players set show_load_message watching.global_values 0"},"hover_event":{"action":"show_text","value":[{"translate":"from_the_fog.message.disable_load.hover","color":"yellow"}]}}]