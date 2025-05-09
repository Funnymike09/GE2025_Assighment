# Whales in a bowl
Simulates behaviour of whales but instead of a huge body of water its scaled to a fishbowl size. 
### Who worked on this project:
Mikhail Fisneko D22124946
Daragh Fiorilla C22736725

# Video showcase

# Screenshots

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