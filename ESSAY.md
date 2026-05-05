# Recreating *Bâton de pluies*

*On curiosity, recreation, and what AI changes (and doesn't change) about how we learn from art.*

---

A few weeks ago I came across a video on X by [@FigsFromPlums](https://x.com/FigsFromPlums/status/2048749126439829716) showing an audiovisual piece called *Bâton de pluies* by [lolalevient](https://www.instagram.com/ilpleut.studio) and [AIRMOW](https://www.instagram.com/airmowmusic) Two narrow vertical panels, side by side. On the left, a thin gray grid where black square pixels fell like rain and stuck briefly at the bottom. On the right, a video of a rainy window, water beading on glass.

It was quiet, deliberate, and physically musical, each pixel that landed playing a soft note, and the whole thing felt like a rain stick tuned to C minor. I watched the video several times. I wanted to know how it worked.

I'm a designer, tinkererand occasional weekend electronic music hobbyist. I read code reasonably well but I don't write applications from scratch. Five years ago, "I want to know how that works" would have stayed a thought. This week, I sat down with Claude (Opus 4.7) and we built our own interpretation of it together over the course of a few conversations.

## What we made

It's a single HTML file that opens in any modern browser. Two panels, like the original. The left panel is a paper-white grid where black pixels fall, accumulate, and erode away. The right panel is procedurally generated, hundreds of tiny water droplets rendered as actual little 3D-looking beads on silver-gray glass, with occasional streaks running down through them. Above and below sit the same minimalist French labels, with `INTENSITÉ` updating live based on how much rain is falling.

Apart from the procedureal rain-feed in the right panel we also added the ability to use a WebCam to trigger the input. Point the camera at anything that moves, like leaves outside your window, a bird feeder, the blinking lights on a server rack — and the motion in the camera image triggers droplets on the grid. Each droplet plays a note in C minor pentatonic, with the column position mapped to pitch (so motion on the left of the camera plays low notes, motion on the right plays high notes). A slow drone pad cycles underneath in i–VI–III–VII. Brown noise, filtered through a slow LFO, gives the whole thing the suggestion of rainfall.

I've been pointing my Sigma fp out of my studio window at a tree. As the leaves catch wind, melodies emerge. Not melodies I composed, butmelodies the *wind* composed, transcribed through motion detection, voiced through C minor. I've been layering soft sine tones from my Teenage Engineering TX-6 over the top. It's the closest I've ever come to making *musique concrète* at the speed of weather.

A dark mode follows your system preference. At night, off-white pixels fall on a near-black grid like snow, and the right panel becomes a starscape of moonlit droplets. With the camera pointing at the rack at night, blinking activity LEDs become an ambient instrument that plays itself based on what your servers are doing.

## Is this okay?

I think this is the more interesting question, and I want to answer it plainly rather than apologetically.

I did not make *Bâton de pluies*. lolalevient and AIRMOW made *Bâton de pluies*. What I made is a recreation, informed by a single screenshot and a video, built in conversation with an AI, extended in directions the original wasn't built to go. **It does not have the soul of the original.** The original is an installation, sited and physical. Mine is a browser tab.

But recreation in pursuit of understanding is how humans have always learned from art. Renaissance painters copied masters to learn how light works. Jazz musicians transcribe solos by ear. Composers write fugues in the style of Bach not to fool anyone but to understand counterpoint from the inside. The act of trying to make something yourself even when, or *especially* when, you fail to match it, teaches you what makes the original good.

What's new is that I could do this without already being a programmer. Claude let me bring my eye for design and my ear for music to a medium I couldn't previously touch. I described what I was seeing; it offered code. That collaboration is not the same as copying. It's closer to learning a language by speaking it badly to a patient teacher until you start speaking it well.

Three things make this ethical to me:

1. **Attribution.** The original artists are named, linked, and credited as the inspiration. I am explicit that this is a recreation, not an original work.
2. **Recreation, not impersonation.** I'm not claiming I made *Bâton de pluies*. I'm sharing what I learned by trying to understand it.
3. **Open, so others can extend it.** The code is on GitHub. If anyone else wants to fork it, build on it, or use it as a jumping-off point for their own piece, please do.


## What I learned

- How procedural rendering of water droplets works (shadow, body, refractive glow, specular highlight, dark meniscus rim — five layered ellipses per drop, drawn once into an offscreen buffer).
- How frame-differencing motion detection works (subtract the previous frame from the current; pixels that differ above a threshold are motion).
- How `getUserMedia` and the modern browser camera API work, and why localhost vs. file:// URLs behave differently for privacy permissions.
- How Tone.js routes voices through reverb and delay buses; how column-position can be mapped to a pentatonic scale; how a slow LFO sweeping a band-pass filter on brown noise sounds remarkably like distant rain.

Each of those is a door. Now that I've walked through them once, I can walk through them again on my own projects. That's the part of this experience that doesn't go away when the tab is closed.

## Try it

A live version is at [your-url-here] *(replace with your hosted URL — GitHub Pages, Netlify, your blog, wherever)*. The source is on [GitHub](https://github.com/annbjer/un-hommage-a-baton-de-pluies). It runs entirely in your browser; the camera feed never leaves your machine. Point it at anything that moves and listen.

And go look at the [original *Bâton de pluies*](https://ilpleut.studio). Mine is a sketch from a video. Theirs is the work.

---

*Thanks to lolalevient and AIRMOW for making something worth recreating and [@FigsFromPlums](https://x.com/FigsFromPlums/status/2048749126439829716) for surfacing it.*
