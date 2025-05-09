# Whales in a bowl
Simulates behaviour of whales but instead of a huge body of water its scaled to a fishbowl size. 
### Who worked on this project:
Mikhail Fisneko D22124946
Daragh Fiorilla C22736725

# Video showcase
[The video showcase](https://youtu.be/2N7B3Z0nAIU)

# Screenshots
![photo_2025-05-10_02-01-18](https://github.com/user-attachments/assets/3a481a12-d045-42ff-87ca-d1c8fb99284e)
![photo_2025-05-10_02-00-43](https://github.com/user-attachments/assets/bc75da93-15a2-4e63-a26a-a80979db5dbb)
![photo_2025-05-10_02-00-19](https://github.com/user-attachments/assets/42b7900d-7ac1-45c6-821c-bf71901cd351)

# Description 
A bunch of boid with different behaviours with a Fmod emmitors that work with the boids to create realistic sounds as well as a separate system for modifying the sound with the depth of water. 

# Controls 
C to change camera state 
When controlling the camera WASD for movment and E to assend 

# Scripts and classes 
Main whale are taken and modifided from examples gvien. 
Modified to be compatable with the Fmod events plus some tweaks for this scene specificaly. 
Schools of fish are made from scratch but basied on the standard boid behaviours.

| Class/asset | Source |
|-----------|-----------|
| boidManager.gd | Self written by Daragh |
| fishBoid.gd | Self written by Daragh |
| MyClass2.cs | From [reference]() |

Shader for water is from this [tutorial](https://youtu.be/5MfcliFqjnE) and modified and tweaked to work with 4.4 godot and with complex geometry. 

### Individual contributions
- Daragh
I contributed by coding the behaviours of the fish in the project. I did this by creating a script modelled off of the boid alogrithm for simulating artificial life created by Craig Reynolds. For this I created a boid manager script which sets the behaviour of the group and their targeted positions (constructed from random point in sphere), as well as constructing the bounds which they stay in (predefined based on our project scene). The boid fish objects themselves use alignment, cohesion and seperation to immitate flocking/swarming behaviour by calculating the position of their neighbours and altering their grouping priorities using the weight of their alignment/cohesion/seperation.
I am most proud of writing the working boid classes from scratch, as it is something I have never tried before.
I learned a lot about simulating artificial life, and programming AI movement on all 3 axes without the use of paths. I also learned about altering the state of AI objects based on the state of other AI, as opposed to writing individual behaviours.

- Mikhail
My contribution consisted of modifying boids to be compatible with the audio system and improving the visuals by doing models, shaders and sounds as well. 
Working with the shaders was springily comfortable and i got quite comfortable with them despite not having a visual system like Unreal or Unity, wouldn't be possible without great sources like https://godotshaders.com.
Despite Fmod addon not being fully perfectly implemented it was enough to get the main features going and set up such an environment. 
I chose to modify already existing scripts like Camera controller and basic boid to be compatible with the Fmod sounds and tweak the parameters such as reverb and depth in real time. (I almost corrupted the main scene file but salvaged it.) 
Overall i would think with more improvements and some time Godot can and will be up there with the big engines that the industry will count as standard 
