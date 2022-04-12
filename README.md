# MiniprojektDET

# State of the Endless Scroller Game:

![image](https://user-images.githubusercontent.com/43958643/162927534-273b90b1-7328-4461-adbe-510801eb94f6.png)

![image](https://user-images.githubusercontent.com/43958643/162927470-ee7e2759-6f1c-4c25-b43c-b7ebffa5e608.png)

  -Demo player that can jump, move, die

  -Demo Map that endlessly scrolls to the right, contains tiles, continiously spawns new tiles and despawns old ones

  -1 way of dealing damage to the player (falling out of map)

  -Game Over Screen that contains a restart Button

  -visualization of players HP
  
# CHARACTER Plan:

-Character can move in any direction

-Character can double jump

-Character can dash (left mouse button)

-Character can block projectiles (right mouse button)

-Character has 3 HP

-Character loses HP only by falling down (-1), hitting damaging obstacles (-1) and getting hit by projectiles (-1)

# MAP Plan:

-the player has to move through different, randomly chosen, tilemaps. These repeat endlessly

-when falling down, player takes 1 damage and gets tped to the top of the screen. (viá Area2d+CollisionShape2D+signal)

-tiles that can damage the player. cactus/spikes/etc

-tiles that hinder the player. cobwebs/minimazes/etc

# GAMEMANAGER:

-all tiles and entities are being moved left continiously by a fixed (speed) factor. This gives the illusion of a camera moving right (endless scroller effect)

-speed is set in the beginning and slowly picks up (every ~20-30 seconds. Maybe there should be an effect played to give more impact)

-the camera can follow the player up, if he ever decides to jump too high (maybe when he respawns, too)

-the player cannot leave Game Area to the left or right. Below is a teleporter that teleports him up

# PROJECTILES (damaging):

-randomly spawning projectiles or fired by spawning enemies

-the main way of getting damaged 

-todo in ~2weeks

# TODO List:

-(done) DEMO player (moving, jumping, hp, hp-lose method) + overlay (hp) (on death-method)

-(done) DEMO Map (endless scrolling map that handles walls and teleports

-(done) DEMO Game Over that allows the player to restart the game

-player overhaul 1 (dashing, double jump, better physics, maybe better sprite)

-game menu (highscore, new game, exit, options, pause) - fully integrated into the demo game.

-projectiles - todo for when someone can do them

-player overhaul 2 (blocking and improvements that came up)

-obstacles - todo for when someone can do them

-damaging obstacles - todo for when someone can do them

-map overhaul, so it gets a random feeling by being pseudo-procedural generated - do when everything else is either done or will certainly be done in time

