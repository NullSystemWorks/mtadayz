resource: Shader Dynamic Sky v2.17
contact: knoblauch700@o2.pl
MODIFIED BY: L (For MTA DayZ)
Update 2.17:
-Added moon 'shine through clouds' multiplier
-Disabled moon aura
Update 2.16:
-Prevent object shaking
-Prevent object disappearing while entering boat
Update 2.14:
-Fixed error: clouds disappearing after switching
Update 2.12:
-Minor updates for external resource support
-added enableHorizonBlending variable
Update 2.09:
-Slowed down clouds movement on xy position change
Update 2.08:
-Added isDynamicSkyEnabled exported function
-The effects adapt to gFogStart when camera is in water
Update 2.07:
-Fixed a typo in moon sphere rotation code
-added getDynamicMoonVector and getMoonPhaseValue exported functions
Update 2.06:
-Changed object size factor from fogEnd to farClip
-Minor changes in depthBias values between effect layers
-Moon vector is now properly set
Update 2.05:
-Fixed 'stars shining through the moon' bug.
Update 2.04:
-Divided the effects into 2 shaders (saves some more frames)
-Different technique for moon
Update 2.03:
-added a bottom cloud effect (it's applied when camera.z reaches farClipDistance)
-fixed effect not reappearing after camera was in water, added alpha fading
-improved framerate a bit by exporting some shader calculations to vertex shader
-rescaled the cloud texture to 768x768
-inverted normalMap
-all object resources are destroyed on clientResourceStop
Update 2.00:
-rewritten moon phase algorithm (uses MTA 1.4 increased precision of floating-points)
-rewritten weather settings
-added a proper timer for sky rotation
-3 pass shader effect written from scratch
-added cloud normal mapping effects
-stratosphere effect at defined height
-added getDynamicSunVector exported function

Description:
This resource adds a dynamic sky for your MTA.
The sun and moon positions depend on the ingame time.
Current (based on server time) moon phase is counted
on resource start.
The night sky created with spacescape-0.3.