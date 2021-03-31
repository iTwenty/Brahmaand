//
//  ApodTestData.swift
//  BrahmaandTests
//
//  Created by jaydeep on 31/03/21.
//

import Foundation
@testable import Brahmaand

struct ApodTestData {
    static var testApods: [Apod] {
        let testApodsJson = """
[
    {
        "copyright": "Petr Horalek",
        "date": "2021-01-01",
        "explanation": "The South Celestial Pole is easy to spot in star trail images of the southern sky. The extension of Earth's axis of rotation to the south, it's at the center of all the southern star trail arcs. In this starry panorama streching about 60 degrees across deep southern skies the South Celestial Pole is somewhere near the middle though, flanked by bright galaxies and southern celestial gems. Across the top of the frame are the stars and nebulae along the plane of our own Milky Way Galaxy. Gamma Crucis, a yellowish giant star heads the Southern Cross near top center, with the dark expanse of the Coalsack nebula tucked under the cross arm on the left. Eta Carinae and the reddish glow of the Great Carina Nebula shine along the galactic plane near the right edge. At the bottom are the Large and Small Magellanic clouds, external galaxies in their own right and satellites of the mighty Milky Way. A line from Gamma Crucis through the blue star at the bottom of the southern cross, Alpha Crucis, points toward the South Celestial Pole, but where exactly is it? Just look for south pole star Sigma Octantis. Analog to Polaris the north pole star, Sigma Octantis is little over one degree fom the the South Celestial pole.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/2020_12_16_Kujal_Jizni_Pol_1500px-3.png",
        "media_type": "image",
        "service_version": "v1",
        "title": "Galaxies and the South Celestial Pole",
        "url": "https://apod.nasa.gov/apod/image/2101/2020_12_16_Kujal_Jizni_Pol_1500px-3.jpg"
    },
    {
        "copyright": "Mike Smolinsky",
        "date": "2021-01-02",
        "explanation": "In the mid 19th century, one of the first photographic technologies used to record the lunar surface was the wet-plate collodion process, notably employed by British astronomer Warren De la Rue. To capture an image, a thick, transparent mixture was used to coat a glass plate, sensitized with silver nitrate, exposed at the telescope, and then developed to create a negative image on the plate. To maintain photographic sensitivity, the entire process, from coating to exposure to developing, had to be completed before the plate dried, in a span of about 10 to 15 minutes. This modern version of a wet-plate collodion image celebrates lunar photography's early days, reproducing the process using modern chemicals to coat a glass plate from a 21st century hardware store. Captured last November 28 with an 8x10 view camera and backyard telescope, it faithfully records large craters, bright rays, and dark, smooth mare of the waxing gibbous Moon. Subsequently digitized, the image on the plate was 8.5 centimeters in diameter and exposed while tracking for 2 minutes. The wet plate's effective photographic sensitivity was about ISO 1.  In your smart phone, the camera sensor probably has a photographic sensitivity range of ISO 100 to 6400 (and needs to be kept dry ...).",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/WetCollodionLunar112820SMO.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "21st Century Wet Collodion Moon",
        "url": "https://apod.nasa.gov/apod/image/2101/WetCollodionLunar112820SMO_1024.jpg"
    },
    {
        "copyright": "Hallgrimur P. Helgason Rollover Annotation: Judy Schmidt",
        "date": "2021-01-03",
        "explanation": "All of the other aurora watchers had gone home. By 3:30 am in Iceland, on a quiet September night, much of that night's auroras had died down. Suddenly, unexpectedly, a new burst of particles streamed down from space, lighting up the Earth's atmosphere once again. This time, surprisingly, pareidoliacally, the night lit up with an  amazing shape reminiscent of a giant phoenix. With camera equipment at the ready, two quick sky images were taken, followed immediately by a third of the land.  The mountain in the background is Helgafell, while the small foreground river is called Kaldá, both located about 30 kilometers north of Iceland's capital Reykjavík. Seasoned skywatchers will note that just above the mountain, toward the left, is the constellation of Orion, while the Pleiades star cluster is also visible just above the frame center.  The 2016 aurora, which lasted only a minute and was soon gone forever --  would possibly be dismissed as an fanciful fable -- were it not captured in the featured, digitally-composed, image mosaic.    Almost Hyperspace: Random APOD Generator",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/PhoenixAurora_Helgason_3130.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "A Phoenix Aurora over Iceland",
        "url": "https://apod.nasa.gov/apod/image/2101/PhoenixAurora_Helgason_960.jpg"
    },
    {
        "copyright": "Thomas Ashcraft",
        "date": "2021-01-04",
        "explanation": "What causes sprite lightning? Mysterious bursts of light in the sky that momentarily resemble gigantic jellyfish have been recorded for over 30 years, but apart from a general association with positive cloud-to-ground lightning, their root cause remains unknown. Some thunderstorms have them -- most don't.  Recently, however, high speed videos are better detailing how sprites actually develop.  The featured video, captured in mid-2019, is fast enough -- at about 100,000 frames per second -- to time-resolve several sprite \\"bombs\\" dropping and developing into the multi-pronged streamers that appear on still images. Unfortunately, the visual clues provided by videos like these do not fully resolve the sprite origins mystery. High speed vidoes do indicate to some researchers, though, that sprites are more likely to occur when plasma irregularities exist in the upper atmosphere.    Astrophysicists: Browse 2,300+ codes in the Astrophysics Source Code Library",
        "media_type": "video",
        "service_version": "v1",
        "title": "Sprite Lightning at 100,000 Frames Per Second",
        "url": "https://www.youtube.com/embed/zS_XgF9i8tc?rel=0"
    },
    {
        "copyright": "José Mtanous",
        "date": "2021-01-05",
        "explanation": "What is the Small Magellanic Cloud? It has turned out to be a galaxy.  People who have wondered about this little fuzzy patch in the southern sky included Portuguese navigator Ferdinand Magellan and his crew, who had plenty of time to study the unfamiliar night sky of the south during the first circumnavigation of planet Earth in the early 1500s. As a result, two celestial wonders easily visible for southern hemisphere skygazers are now known in Western culture as the Clouds of Magellan. Within the past 100 years, research has shown that these cosmic clouds are dwarf irregular galaxies, satellites of our larger spiral Milky Way Galaxy. The Small Magellanic Cloud actually spans 15,000 light-years or so and contains several hundred million stars. About 210,000 light-years away in the constellation of the Tucan (Tucana), it is more distant than other known Milky Way satellite galaxies, including the Sagittarius Dwarf galaxy and the Large Magellanic Cloud. This sharp image also includes the foreground globular star cluster 47 Tucanae on the right.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/SMC_Mtanous_4464.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "The Small Cloud of Magellan",
        "url": "https://apod.nasa.gov/apod/image/2101/SMC_Mtanous_960.jpg"
    },
    {
        "date": "2021-01-06",
        "explanation": "Why are these sand dunes on Mars striped?  No one is sure.  The featured image shows striped dunes in Kunowsky Crater on Mars, photographed recently with the Mars Reconnaissance Orbiter’s HiRISE Camera.  Many Martian dunes are known to be covered unevenly with carbon dioxide (dry ice) frost, creating patterns of light and dark areas.  Carbon dioxide doesn’t melt, but sublimates, turning directly into a gas. Carbon dioxide is also a greenhouse material even as a solid, so it can trap heat under the ice and sublimate from the bottom up, causing geyser-like eruptions.  During Martian spring, these eruptions can cause a pattern of dark defrosting spots, where the darker sand is exposed.  The featured image, though, was taken during Martian autumn, when the weather is getting colder – making these stripes particularly puzzling.  One hypothesis is that they are caused by cracks in the ice that form from weaker eruptions or thermal stress as part of the day-night cycle, but research continues.  Watching these dunes and others through more Martian seasons may give us more clues to solve this mystery.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/StripedDunes_HiRISE_1182.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Striped Sand Dunes on Mars",
        "url": "https://apod.nasa.gov/apod/image/2101/StripedDunes_HiRISE_1080.jpg"
    },
    {
        "copyright": "Miloslav Druckmuller",
        "date": "2021-01-07",
        "explanation": "Along a narrow path crossing southern South America through Chile and Argentina, the final New Moon of 2020 moved in front of the Sun on December 14 in the year's only total solar eclipse. Within about 2 days of perigee, the closest point in its elliptical orbit, the New Moon's surface is faintly lit by earthshine in this dramatic composite view. The image is a processed composite of 55 calibrated exposures ranging from 1/640 to 3 seconds. Covering a large range in brightness during totality, it reveals the dim lunar surface and faint background stars, along with planet-sized prominences at the Sun's edge, an enormous coronal mass ejection, and sweeping coronal structures normally hidden in the Sun's glare. Look closely for an ill-fated sungrazing Kreutz family comet (C/2020 X3 SOHO) approaching from the lower left, at about the 7 o'clock position. In 2021 eclipse chasers will see an annular solar eclipse coming up on June 10. They'll have to wait until December 4 for the only total solar eclipse in 2021 though. That eclipse will be total along a narrow path crossing the southernmost continent of Antarctica.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/Tse_2020_400mm_dmwa-rot.png",
        "media_type": "image",
        "service_version": "v1",
        "title": "Total Solar Eclipse 2020",
        "url": "https://apod.nasa.gov/apod/image/2101/Tse_2020_400mm_dmwa-rot.jpg"
    },
    {
        "copyright": "island universe",
        "date": "2021-01-08",
        "explanation": "Barred spiral galaxy NGC 1365 is truly a majestic island universe some 200,000 light-years across. Located a mere 60 million light-years away toward the chemical constellation Fornax, NGC 1365 is a dominant member of the well-studied Fornax Cluster of galaxies. This impressively sharp color image shows the intense, reddish star forming regions near the ends of central bar and along the spiral arms, with details of the obscuring dust lanes cutting across the galaxy's bright core. At the core lies a supermassive black hole. Astronomers think NGC 1365's prominent bar plays a crucial role in the galaxy's evolution, drawing gas and dust into a star-forming maelstrom and ultimately feeding material into the central black hole.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/NGC-1365-RGB-19-DEC-2020_Leo_Mike.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "NGC 1365: Majestic Island Universe",
        "url": "https://apod.nasa.gov/apod/image/2101/NGC-1365-RGB-19-DEC-2020_Leo_Mike_1024.jpg"
    },
    {
        "date": "2021-01-09",
        "explanation": "Like Earth's moon, Saturn's largest moon Titan is locked in synchronous rotation. This mosaic of images recorded by the Cassini spacecraft in May of 2012 shows its anti-Saturn side, the side always facing away from the ringed gas giant. The only moon in the solar system with a dense atmosphere, Titan is the only solar system world besides Earth known to have standing bodies of liquid on its surface and an earthlike cycle of liquid rain and evaporation. Its high altitude layer of atmospheric haze is evident in the Cassini view of the 5,000 kilometer diameter moon over Saturn's rings and cloud tops. Near center is the dark dune-filled region known as Shangri-La. The Cassini-delivered Huygens probe rests below and left of center, after the most distant landing for a spacecraft from Earth.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/PIA19642Titan.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Titan: Moon over Saturn",
        "url": "https://apod.nasa.gov/apod/image/2101/PIA19642Titan1024.jpg"
    },
    {
        "date": "2021-01-10",
        "explanation": "In the center of nearby star-forming region lies a huge cluster containing some of the largest, hottest, and most massive stars known. These stars, known collectively as star cluster R136, part of the Tarantula Nebula, were captured in the featured image in visible light in 2009 through the Hubble Space Telescope. Gas and dust clouds in the Tarantula Nebula, have been sculpted into elongated shapes by powerful winds and ultraviolet radiation from these hot cluster stars.  The Tarantula Nebula lies within a neighboring galaxy known as the Large Magellanic Cloud and is located a mere 170,000 light-years away.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/30dor_hubble_3939.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Star Cluster R136 Breaks Out",
        "url": "https://apod.nasa.gov/apod/image/2101/30dor_hubble_960.jpg"
    },
    {
        "date": "2021-01-11",
        "explanation": "What will the Moon phase be on your birthday this year?  It is hard to predict because the Moon's appearance changes nightly.  As the Moon orbits the Earth, the half illuminated by the Sun first becomes increasingly visible, then decreasingly visible. The featured video animates images taken by NASA's Moon-orbiting Lunar Reconnaissance Orbiter to show all 12 lunations that appear this year, 2021. A single lunation describes one full cycle of our Moon, including all of its phases. A full lunation takes about 29.5 days, just under a month (moon-th). As each lunation progresses, sunlight reflects from the Moon at different angles, and so illuminates different features differently.  During all of this, of course, the Moon always keeps the same face toward the Earth. What is less apparent night-to-night is that the Moon's apparent size changes slightly, and that a slight wobble called a libration occurs as the Moon progresses along its elliptical orbit.   APOD online webinar January 12: Free registration, hosted by Amateur Astronomers Association of New York.",
        "media_type": "video",
        "service_version": "v1",
        "title": "Moon Phases in 2021",
        "url": "https://www.youtube.com/embed/8XV2-pmiyAg?rel=0"
    },
    {
        "copyright": "Rodrigo Guerra",
        "date": "2021-01-12",
        "explanation": "The night sky is filled with stories. Cultures throughout history have projected some of their most enduring legends onto the stars above. Generations of people see these stellar constellations, hear the associated stories, and pass them down. Featured here is the perhaps unfamiliar constellation of the Old Man, long recognized by the Tupi peoples native to regions of South America now known as Brazil.  The Old Man, in more modern vernacular, may be composed of the Hyades star cluster as his head and the belt of Orion as part of one leg.  Tupi folklore relates that the other leg was cut off by his unhappy wife, causing it to end at the orange star now known as Betelgeuse. The Pleiades star cluster, on the far left, can be interpreted as a head feather. In the featured image, the hobbled Old Man is mirrored by a person posing in the foreground.  Folklore of the night sky is important for many reasons, including that it records cultural heritage and documents the universality of human intelligence and imagination.    APOD in world languages: Arabic, Catalan, Chinese (Beijing), Chinese (Taiwan), Croatian, Czech, Dutch, Farsi, French, German, Hebrew, Indonesian, Japanese, Korean, Montenegrin, Polish, Russian, Serbian, Slovenian,  Spanish, Taiwanese, Turkish, Turkish, and  Ukrainian  APOD online webinar January 12: Free registration, hosted by Amateur Astronomers Association of New York.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/OldMan_Guerra_6000.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "A Historic Brazilian Constellation",
        "url": "https://apod.nasa.gov/apod/image/2101/OldMan_Guerra_960_lines.jpg"
    },
    {
        "copyright": "Giulio Cobianchi",
        "date": "2021-01-13",
        "explanation": "What are these two giant arches across the sky? Perhaps the more familiar one, on the left, is the central band of our Milky Way Galaxy. This grand disk of stars and nebulas here appears to encircle much of the southern sky. Visible below the stellar arch is the rusty-orange planet Mars and the extended Andromeda galaxy. For a few minutes during this cold arctic night, a second giant arch appeared to the right, encircling part of the northern sky: an aurora. Auroras are much closer than stars as they are composed of glowing air high in Earth's atmosphere.  Visible outside the green auroral arch is the group of stars popularly known as the Big Dipper.  The featured digital composite of 18 images was captured in mid-December over the Lofoten Islands in Norway.    APOD Year in Review (2020): RJN's Night Sky Network Lecture",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/ArcticSky_Cobianchi_2048.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Arches Across an Arctic Sky",
        "url": "https://apod.nasa.gov/apod/image/2101/ArcticSky_Cobianchi_1080.jpg"
    },
    {
        "date": "2021-01-14",
        "explanation": "Like salsa verde on your favorite burrito, a green aurora slathers up the sky in this 2017 June 25 snapshot from the International Space Station. About 400 kilometers (250 miles) above Earth, the orbiting station is itself within the upper realm of the auroral displays. Aurorae have the signature colors of excited molecules and atoms at the low densities found at extreme altitudes. Emission from atomic oxygen dominates this view. The tantalizing glow is green at lower altitudes, but rarer reddish bands extend above the space station's horizon. The orbital scene was captured while passing over a point south and east of Australia, with stars above the horizon at the right belonging to the constellation Canis Major, Orion's big dog. Sirius, alpha star of Canis Major, is the brightest star near the Earth's limb.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/aurora_iss052e007857.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Aurora Slathers Up the Sky",
        "url": "https://apod.nasa.gov/apod/image/2101/aurora_iss052e007857.jpg"
    },
    {
        "date": "2021-01-15",
        "explanation": "This shadowy landscape of majestic mountains and icy plains stretches toward the horizon on a small, distant world. It was captured from a range of about 18,000 kilometers when New Horizons looked back toward Pluto, 15 minutes after the spacecraft's closest approach on July 14, 2015. The dramatic, low-angle, near-twilight scene follows rugged mountains formally known as Norgay Montes from foreground left, and Hillary Montes along the horizon, giving way to smooth Sputnik Planum at right. Layers of Pluto's tenuous atmosphere are also revealed in the backlit view. With a strangely familiar appearance, the frigid terrain likely includes ices of nitrogen and carbon monoxide with water-ice mountains rising up to 3,500 meters (11,000 feet). That's comparable in height to the majestic mountains of planet Earth. The Plutonian landscape is 380 kilometers (230 miles) across.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/Pluto-Mountains-Plains9-17-15.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "A Plutonian Landscape",
        "url": "https://apod.nasa.gov/apod/image/2101/Pluto-Mountains-Plains9-17-15_1024.jpg"
    },
    {
        "date": "2021-01-16",
        "explanation": "This fantastic skyscape lies near the edge of NGC 2174 a star forming region about 6,400 light-years away in the nebula-rich constellation of Orion. It follows mountainous clouds of gas and dust carved by winds and radiation from the region's newborn stars, now found scattered in open star clusters embedded around the center of NGC 2174, off the top of the frame. Though star formation continues within these dusty cosmic clouds they will likely be dispersed by the energetic newborn stars within a few million years. Recorded at infrared wavelengths by the Hubble Space Telescope in 2014, the interstellar scene spans about 6 light-years. Scheduled for launch in 2021, the James Webb Space Telescope is optimized for exploring the Universe at infrared wavelengths.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/hs-2014-18_n2174rotate.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "The Mountains of NGC 2174",
        "url": "https://apod.nasa.gov/apod/image/2101/hs-2014-18_n2174rotate1024.jpg"
    },
    {
        "date": "2021-01-17",
        "explanation": "The jets emanating from Centaurus A are over a million light years long. These jets of streaming plasma, expelled by a giant black hole in the center of this spiral galaxy,  light up this composite image of Cen A. Exactly how the central black hole expels infalling matter remains unknown. After clearing the galaxy, however, the jets inflate large radio bubbles that likely glow for millions of years. If energized by a passing gas cloud, the radio bubbles can even light up again after billions of years. X-ray light is depicted in the featured composite image in blue, while microwave light is colored orange.  The base of the jet in radio light shows details of the innermost light year of the central jet.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/CenAjets_EsoNasa_1280.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Jets from Unusual Galaxy Centaurus A",
        "url": "https://apod.nasa.gov/apod/image/2101/CenAjets_EsoNasa_960.jpg"
    },
    {
        "copyright": "Russell Croman",
        "date": "2021-01-18",
        "explanation": "What powers this unusual nebula? CTB-1 is the expanding gas shell that was left when a massive star toward the constellation of Cassiopeia exploded about 10,000 years ago. The star likely detonated when it ran out of elements, near its core, that could create stabilizing pressure with nuclear fusion. The resulting supernova remnant, nicknamed the Medulla Nebula for its brain-like shape, still glows in visible light by the heat generated by its collision with confining interstellar gas.  Why the nebula also glows in X-ray light, though, remains a mystery. One hypothesis holds that an energetic pulsar was co-created that powers the nebula with a fast outwardly moving wind. Following this lead, a pulsar has recently been found in radio waves that appears to have been expelled by the supernova explosion at over 1000 kilometers per second.  Although the Medulla Nebula appears as large as a full moon, it is so faint that it took 130-hours of exposure with two small telescopes in New Mexico, USA, to create the featured image.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/Medulla_Croman_1200.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "The Medulla Nebula Supernova Remnant",
        "url": "https://apod.nasa.gov/apod/image/2101/Medulla_Croman_960.jpg"
    },
    {
        "copyright": "Alessandra Masi",
        "date": "2021-01-19",
        "explanation": "Why does a cloudy moon sometimes appear colorful? The effect, called a lunar corona, is created by the quantum mechanical diffraction of light around individual, similarly-sized water droplets in an intervening but mostly-transparent cloud. Since light of different colors has different wavelengths, each color diffracts differently. Lunar Coronae are one of the few  quantum mechanical color effects that can be easily seen with the unaided eye.  Solar coronae are also sometimes evident.  The featured composite image was captured a few days before the close Great Conjunction between Saturn and Jupiter last month. In the foreground, the Italian village of Pieve di Cadore is visible in front of the Sfornioi Mountains.    New: APOD is now available in Taiwanese from National Central University",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/CoronaConjunction_Masi_1280.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "A Lunar Corona with Jupiter and Saturn",
        "url": "https://apod.nasa.gov/apod/image/2101/CoronaConjunction_Masi_1080.jpg"
    },
    {
        "date": "2021-01-20",
        "explanation": "Do magnetic fields always flow along spiral arms?  Our face-on view of the Whirlpool Galaxy (M51) allows a spectacularly clear view of the spiral wave pattern in a disk-shaped galaxy.  When observed with a radio telescope, the magnetic field appears to trace the arms' curvature.  However, with NASA’s flying Stratospheric Observatory for Infrared Astronomy (SOFIA) observatory, the magnetic field at the outer edge of M51's disk appears to weave across the arms instead.  Magnetic fields are inferred by grains of dust aligning in one direction and acting like polaroid glasses on infrared light.  In the featured image, the field orientations determined from this polarized light are algorithmically connected, creating streamlines.  Possibly the gravitational tug of the companion galaxy, at the top of the frame, on the dusty gas of the reddish star-forming regions, visible in the Hubble Space Telescope image, enhances turbulence -- stirring the dust and lines to produce the unexpected field pattern of the outer arms.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/M51Bfield_Sofia_2286.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "The Magnetic Field of the Whirlpool Galaxy",
        "url": "https://apod.nasa.gov/apod/image/2101/M51Bfield_Sofia_960.jpg"
    },
    {
        "copyright": "Wes Higgins",
        "date": "2021-01-21",
        "explanation": "Interstellar dust clouds and glowing nebulae abound in the fertile constellation of Orion. One of the brightest, M78, is centered in this colorful, wide field view, covering an area north of Orion's belt. At a distance of about 1,500 light-years, the bluish reflection nebula is around 5 light-years across. Its tint is due to dust preferentially reflecting the blue light of hot, young stars. Reflection nebula NGC 2071 is just to the left of M78. Flecks of emission from Herbig-Haro objects, energetic jets from stars in the process of formation, stand out against the dark dust lanes. The exposure also brings out the region's fainter, pervasive reddish glow of atomic hydrogen gas.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/M78wideHiggins.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "M78 Wide Field",
        "url": "https://apod.nasa.gov/apod/image/2101/M78wideHiggins1024.jpg"
    },
    {
        "copyright": "Alvin Wu",
        "date": "2021-01-22",
        "explanation": "An expanse of cosmic dust, stars and nebulae along the plane of our Milky Way galaxy form a beautiful ring in this projected all-sky view. The creative panorama covers the entire galaxy visible from planet Earth, an ambitious 360 degree mosaic that took two years to complete. Northern hemisphere sites in western China and southern hemisphere sites in New Zealand were used to collect the image data. Like a glowing jewel set in the milky ring, the bulge of the galactic center, is at the very top. Bright planet Jupiter is the beacon just above the central bulge and left of red giant star Antares. Along the plane and almost 180 degrees from the galactic center, at the bottom of the ring is the area around Orion, denizen of the northern hemisphere's evening winter skies. In this projection the ring of the Milky Way encompasses two notable galaxies in southern skies, the large and small Magellanic clouds.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/MilkyWayRingAlvinWu.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "The Milky Ring",
        "url": "https://apod.nasa.gov/apod/image/2101/MilkyWayRingAlvinWu1024.jpg"
    },
    {
        "date": "2021-01-23",
        "explanation": "Massive stars in our Milky Way Galaxy live spectacular lives.  Collapsing from vast cosmic clouds, their nuclear furnaces ignite and create heavy elements in their cores. After a few million years, the enriched material is blasted back into interstellar space where star formation can begin anew. The expanding debris cloud known as Cassiopeia A is an example of this final phase of the stellar life cycle. Light from the explosion which created this supernova remnant would have been first seen in planet Earth's sky about 350 years ago, although it took that light about 11,000 years to reach us. This false-color image, composed of X-ray and optical image data from the Chandra X-ray Observatory and Hubble Space Telescope, shows the still hot filaments and knots in the remnant. It spans about 30 light-years at the estimated distance of Cassiopeia A. High-energy X-ray emission from specific elements has been color coded, silicon in red, sulfur in yellow, calcium in green and iron in purple, to help astronomers explore the recycling of our galaxy's star stuff. Still expanding, the outer blast wave is seen in blue hues. The bright speck near the center is a neutron star, the incredibly dense, collapsed remains of the massive stellar core.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/Chandrafirstlight_0.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Recycling Cassiopeia A",
        "url": "https://apod.nasa.gov/apod/image/2101/Chandrafirstlight_0_1024.jpg"
    },
    {
        "copyright": "Roberto Colombari",
        "date": "2021-01-24",
        "explanation": "It is one of the more massive galaxies known. A mere 46 million light-years distant, spiral galaxy NGC 2841 can be found in the northern constellation of Ursa Major. This sharp view of the gorgeous island universe shows off a striking yellow nucleus and galactic disk. Dust lanes, small, pink star-forming regions, and young blue star clusters are embedded in the patchy, tightly wound spiral arms. In contrast, many other spirals exhibit grand, sweeping arms with large star-forming regions.  NGC 2841 has a diameter of over 150,000 light-years, even larger than our own Milky Way. The featured composite image merges exposures from the orbiting 2.4-meter Hubble Space Telescope and the ground-based 8.2-meter Subaru Telescope.  X-ray images suggest that resulting winds and stellar explosions create plumes of hot gas extending into a halo around NGC 2841.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/ngc2841_hstColombari_2896.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Massive Nearby Spiral Galaxy NGC 2841",
        "url": "https://apod.nasa.gov/apod/image/2101/ngc2841_hstColombari_960.jpg"
    },
    {
        "copyright": "Tomáš Slovinský",
        "date": "2021-01-25",
        "explanation": "Have you ever seen the Southern Cross? This famous four-star icon is best seen from Earth's Southern Hemisphere. The featured image was taken last month in Chile and captures the Southern Cross just to the left of erupting Villarrica, one of the most active volcanos in our Solar System.  Connecting the reddest Southern Cross star Gacrux through the brightest star  Acrux points near the most southern location in the sky: the South Celestial Pole (SCP), around which all southern stars appear to spin as the Earth turns. In modern times, no bright star resides near the SCP, unlike in the north where bright Polaris now appears near the NCP.  Extending the Gacrux - Acrux line still further (from about four to about seven times their angular separation) leads near the Small Magellanic Cloud, a bright satellite galaxy of our Milky Way Galaxy.  The Southern Cross asterism dominates the Crux constellation, a deeper array of stars that includes four Cepheid variable stars visible to the unaided eye. Just above the volcano in the image, and looking like a dark plume, is the Coalsack Nebula, while the large red star-forming Carina Nebula is visible on the upper left.   Portal Universe: Random APOD Generator",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/SouthernCross_Slovinsky_3000.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Southern Cross over Chilean Volcano",
        "url": "https://apod.nasa.gov/apod/image/2101/SouthernCross_Slovinsky_960.jpg"
    },
    {
        "date": "2021-01-26",
        "explanation": "How did this strange-looking galaxy form?  Astronomers turn detectives when trying to figure out the cause of unusual jumbles of stars, gas, and dust like NGC 1316. Inspection indicates that NGC 1316 is an enormous elliptical galaxy that somehow includes dark dust lanes usually found in a spiral galaxy.  Detailed images taken by the Hubble Space Telescope shows details, however, that help in reconstructing the history of this gigantic tangle.  Deep and wide images show huge collisional shells, while deep central images reveal fewer globular clusters of stars toward NGC 1316's interior.  Such effects are expected in galaxies that have undergone collisions or merging with other galaxies in the past few billion years.  The dark knots and lanes of dust, prominent in the featured image, indicate that one or more of the devoured galaxies were spiral galaxies.  NGC 1316 spans about 50,000 light years and lies about 60 million light years away toward the constellation of the Furnace (Fornax).",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/NGC1316Center_HubbleNobre_2585.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Central NGC 1316: After Galaxies Collide",
        "url": "https://apod.nasa.gov/apod/image/2101/NGC1316Center_HubbleNobre_960.jpg"
    },
    {
        "date": "2021-01-27",
        "explanation": "How far do magnetic fields extend up and out of spiral galaxies?  For decades astronomers knew only that some spiral galaxies had magnetic fields.  However, after NRAO's Very Large Array (VLA) radio telescope (popularized in the movie Contact) was upgraded in 2011, it was unexpectedly discovered that these fields could extend vertically away from the disk by several thousand light-years.  The featured image of edge-on spiral galaxy NGC 5775, observed in the CHANG-ES (Continuum Halos in Nearby Galaxies) survey, also reveals spurs of magnetic field lines that may be common in spirals.  Analogous to iron filings around a bar magnet, radiation from electrons trace galactic magnetic field lines by spiraling around these lines at almost the speed of light.  The filaments in this image are constructed from those tracks in VLA data.  The visible light image, constructed from Hubble Space Telescope data, shows pink gaseous regions where stars are born.  It seems that winds from these regions help form the magnificently extended galactic magnetic fields.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/NGC5775_NraoEnglish_6067.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "The Vertical Magnetic Field of NGC 5775",
        "url": "https://apod.nasa.gov/apod/image/2101/NGC5775_NraoEnglish_1080.jpg"
    },
    {
        "date": "2021-01-28",
        "explanation": "Big, beautiful spiral galaxy Messier 66 lies a mere 35 million light-years away. The gorgeous island universe is about 100 thousand light-years across, similar in size to the Milky Way. This reprocessed Hubble Space Telescope close-up view spans a region about 30,000 light-years wide around the galactic core. It shows the galaxy's disk dramatically inclined to our line-of-sight. Surrounding its bright core, the likely home of a supermassive black hole, obscuring dust lanes and young, blue star clusters sweep along spiral arms dotted with the tell-tale glow of pinksh star forming regions. Messier 66, also known as NGC 3627, is the brightest of the three galaxies in the gravitationaly interacting Leo Triplet.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/M66_Hubble_LeoShatz_Crop.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Messier 66 Close Up",
        "url": "https://apod.nasa.gov/apod/image/2101/M66_Hubble_LeoShatz_Crop1024.jpg"
    },
    {
        "copyright": "Liron Gertsman",
        "date": "2021-01-29",
        "explanation": "On January 21, light from the Moon near first quarter illuminated the foreground in this snowy mountain and night scene. Known as The Lions, the striking pair of mountain peaks are north of Vancouver, British Colombia, Canada, North America, planet Earth. Poised above the twin summits, left of Deneb alpha star of the constellation Cygnus, are emission regions NGC 7000 and IC 5070. Part of a large star forming complex about 1,500 light-years from Vancouver, they shine with the characteristic red glow of atomic hydrogen gas. Outlines of the bright emission regions suggest their popular names, The North America Nebula and The Pelican Nebula. The well-planned, deep nightscape is a composite of consecutive exposures made with a modified digital camera and telephoto lens. Foreground exposures were made with camera fixed to a tripod, background exposures were made tracking the sky. The result preserves sharp natural detail and reveals a range of brightness and color that your eye can't quite see on its own.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/North-America-Nebula-Deepscape_Liron-Gertsman.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "North American Nightscape",
        "url": "https://apod.nasa.gov/apod/image/2101/North-America-Nebula-Deepscape_Liron-Gertsman1024.jpg"
    },
    {
        "copyright": "Ralf Rohner",
        "date": "2021-01-30",
        "explanation": "Celestial sights of the southern sky shine above a cloudy planet Earth in this gorgeous night sky view. The scene was captured from an airliner's flight deck at 38,000 feet on a steady westbound ride to Lima, Peru. To produce the sharp airborne astrophotograph, the best of a series of short exposures were selected and digitally stacked. The broad band of the southern Milky Way begins at top left with the dark Coalsack Nebula and Southern Cross. Its expanse of diffuse starlight encompasses the the Carina Nebula and large Gum Nebula toward the right. Canopus, alpha star of Carina and second brightest star in Earth's night is easy to spot below the Milky Way, as is the dwarf galaxy known as the Large Magellanic Cloud. The Small Magellanic cloud just peeks above the cloudy horizon. Of course, the South Celestial Pole also lies within the starry southern frame.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/SouthernSkyRohner.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Southern Sky from 38,000 Feet",
        "url": "https://apod.nasa.gov/apod/image/2101/SouthernSkyRohner1200.jpg"
    },
    {
        "date": "2021-01-31",
        "explanation": "Rocks from space hit Earth every day.  The larger the rock, though, the less often Earth is struck.  Many kilograms of space dust pitter to Earth daily. Larger bits appear initially as a bright meteor.  Baseball-sized rocks and ice-balls streak through our atmosphere daily, most evaporating quickly to nothing.  Significant threats do exist for rocks near 100 meters in diameter, which strike the Earth roughly every 1000 years.  An object this size could cause significant tsunamis were it to strike an ocean, potentially devastating even distant shores. A collision with a massive asteroid, over 1 km across, is more rare, occurring typically millions of years apart, but could have truly global consequences. Many asteroids remain undiscovered.  In the featured image, one such asteroid -- shown by the long blue streak -- was found by chance in 1998 by the Hubble Space Telescope. A collision with a large asteroid  would not affect Earth's orbit so much as raise dust that would affect Earth's climate.  One likely result is a global extinction of many species of life, possibly dwarfing the ongoing extinction occurring now.",
        "hdurl": "https://apod.nasa.gov/apod/image/2101/AsteroidStreak_hst_960.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Asteroids in the Distance",
        "url": "https://apod.nasa.gov/apod/image/2101/AsteroidStreak_hst_960.jpg"
    }
]
"""
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Constants.DateFormatters.apodApiFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! decoder.decode([Apod].self, from: testApodsJson.data(using: .utf8)!)
    }
}
