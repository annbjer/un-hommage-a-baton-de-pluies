# Recreating *Bâton de pluies*

*On curiosity, recreation, and what AI changes (and doesn't change) about how we learn from art.*

---

A few weeks ago I came across a video on X by [@FigsFromPlums](https://x.com/FigsFromPlums/status/2048749126439829716) showing an audiovisual piece called *Bâton de pluies* by [lolalevient](https://www.instagram.com/ilpleut.studio) and [AIRMOW](https://www.instagram.com/airmowmusic). Two narrow vertical panels, side by side. On the left, a thin gray grid where black square pixels fell like rain and stuck briefly at the bottom. On the right, a video of a rainy window, water beading on glass.

It was quiet, deliberate, and physically musical, each pixel that landed playing a soft note, and the whole thing felt like a rain stick tuned to C minor. I watched the video several times. I wanted to know how it worked.

I'm a designer, tinkerer and occasional weekend electronic music hobbyist. I read code reasonably well but I don't write applications from scratch. Five years ago, "I want to know how that works" would have stayed a thought. This week, I sat down with Claude (Opus 4.7) and we built our own interpretation of it together over the course of a few conversations.

## What we made

It's a single HTML file that opens in any modern browser. Two panels, like the original. The left panel is a paper-white grid where black pixels fall, accumulate, and erode away. The right panel is procedurally generated, hundreds of tiny water droplets rendered as actual little 3D-looking beads on silver-gray glass, with occasional streaks running down through them. Above and below sit the same minimalist French labels, with `INTENSITÉ` updating live based on how much rain is falling.

Apart from the procedural rain-feed in the right panel we also added the ability to use a webcam to trigger the input. Point the camera at anything that moves, like leaves outside your window, a bird feeder, the blinking lights on a server rack, and the motion in the camera image triggers droplets on the grid. Each droplet plays a note in C minor pentatonic, with the column position mapped to pitch (so motion on the left of the camera plays low notes, motion on the right plays high notes). A slow drone pad cycles underneath in i–VI–III–VII. Brown noise, filtered through a slow LFO, gives the whole thing the suggestion of rainfall.

I've been pointing my Sigma fp out of my studio window at a tree. As the leaves catch wind, melodies emerge. Not melodies I composed, but melodies the *wind* composed, transcribed through motion detection, voiced through C minor. I've been layering soft sine tones from my Teenage Engineering TX-6 over the top. It's the closest I've ever come to making *musique concrète* at the speed of weather.

A dark mode follows your system preference. At night, off-white pixels fall on a near-black grid like snow, and the right panel becomes a starscape of moonlit droplets. With the camera pointing at the rack at night, blinking activity LEDs become an ambient instrument that plays itself based on what your servers are doing.

## Is this okay?

Fair question. I asked myself the same thing.

I didn't make *Bâton de pluies*. lolalevient and AIRMOW made *Bâton de pluies*. What I made is a browser-based homage, a recreation built from a screenshot, a video, a lot of curiosity, and a long conversation with Claude. It's not the same thing. The original is physical, spatial, alive in a room. Mine runs in a tab.

But trying to recreate something is one of the oldest ways to learn from it. Painters copy paintings. Musicians transcribe solos by ear. You don't do it to claim you invented the thing, you do it because taking something apart and putting it back together is how you find where the magic actually lives.

Claude made it possible for me to work in a medium I don't normally have access to. I could describe what I saw and heard, the falling shapes, the camera movement, rain turning into music, and it helped translate that into code. Not perfectly, not instantly, but enough that I could keep pushing, adjusting, breaking things, fixing them, and slowly understanding more.

So no, I don't see this as claiming someone else's work. I see it as a study. The original artists are credited, this is explicitly a recreation, and the code is open for anyone to learn from or take somewhere new.

I started by trying to understand someone else's beautiful idea. I ended up with a tool, a process, and a little more confidence that I can make things like this myself.

Mine is a sketch from a video. Theirs is the work.


## What I learned

- How procedural rendering of water droplets works (shadow, body, refractive glow, specular highlight, dark meniscus rim, five layered ellipses per drop, drawn once into an offscreen buffer).
- How frame-differencing motion detection works (subtract the previous frame from the current; pixels that differ above a threshold are motion).
- How `getUserMedia` and the modern browser camera API work, and why localhost vs. file:// URLs behave differently for privacy permissions.
- How Tone.js routes voices through reverb and delay buses; how column-position can be mapped to a pentatonic scale; how a slow LFO sweeping a band-pass filter on brown noise sounds remarkably like distant rain.

Each of those is a door. Now that I've walked through them once, I can walk through them again on my own projects. That's the part of this experience that doesn't go away when the tab is closed.

## Try it

A live version is at [annbjer.github.io/un-hommage-a-baton-de-pluies](https://annbjer.github.io/un-hommage-a-baton-de-pluies/un-hommage-a-baton-de-pluies.html). The source is on [GitHub](https://github.com/annbjer/un-hommage-a-baton-de-pluies). It runs entirely in your browser; the camera feed never leaves your machine. Point it at anything that moves and listen.

And go look at the [original *Bâton de pluies*](https://ilpleut.studio). Mine is a sketch from a video. Theirs is the work.

---

*Thanks to lolalevient and AIRMOW for making something worth recreating and [@FigsFromPlums](https://x.com/FigsFromPlums/status/2048749126439829716) for surfacing it.*
