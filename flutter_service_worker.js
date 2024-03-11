'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "4ead9e985fd06ff9dbe24f95575499ff",
"index.html": "d258522fc57da83ddcfdcaab96cc19fe",
"/": "d258522fc57da83ddcfdcaab96cc19fe",
"main.dart.js": "6a2e969331ae01619d4497c10302850c",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "15d66e9fecb37eaf479884cb83846c41",
"assets/AssetManifest.json": "3748a555210900bd68316b0128d35b60",
"assets/NOTICES": "34c87a96d6533d622eebb85d76f5dcaf",
"assets/FontManifest.json": "1f2202f6a453700fca2061f8188c8ce0",
"assets/AssetManifest.bin.json": "a8d880ec792b78877057274232b11284",
"assets/packages/window_manager/images/ic_chrome_unmaximize.png": "4a90c1909cb74e8f0d35794e2f61d8bf",
"assets/packages/window_manager/images/ic_chrome_minimize.png": "4282cd84cb36edf2efb950ad9269ca62",
"assets/packages/window_manager/images/ic_chrome_maximize.png": "af7499d7657c8b69d23b85156b60298c",
"assets/packages/window_manager/images/ic_chrome_close.png": "75f4b8ab3608a05461a31fc18d6b47c2",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.bin": "b1ad30760f41c374ec3d2957e6d4c801",
"assets/fonts/MaterialIcons-Regular.otf": "de83753306f0cb5f3293683d872f07c0",
"assets/assets/images/sprites/bomb.png": "355874946aa62c9e3216c5e87a5ade5e",
"assets/assets/images/sprites/ball.png": "171ea5987ad4c5bfc3110c35769b30bf",
"assets/assets/images/sprites/egg_enemy.png": "1b803873ff360679a12be3639179a5dd",
"assets/assets/images/sprites/banana_enemy.png": "ddddbb59acbf8158f80a7b3013fa09d5",
"assets/assets/images/sprites/powerup.png": "ded27abbd1de76d668cd3c9d28859659",
"assets/assets/images/sprites/map.png": "f25b9bfbeaa7c7d507a7f9691a9f9884",
"assets/assets/images/sprites/apple_enemy.png": "446ba41c3c909f5c53a9cd113f054cdf",
"assets/assets/images/sprites/shuriken_overlay.png": "629298278d1018669aa4ba35f8d6f717",
"assets/assets/images/sprites/heart.png": "6e14d1f25ab9d2b12d5b93135462f2af",
"assets/assets/images/sprites/kunai.png": "b52c4c86552f629efeaf11a9101a1c63",
"assets/assets/images/sprites/shuriken.png": "1df7610cfa94a08d5e2d7d3872b6a032",
"assets/assets/images/sprites/player/main.png": "7bd19b4051b89ea626a5cecd8fce8f4c",
"assets/assets/images/sprites/player/move.png": "8c04995e84d0574304d37c44a6b5e3f7",
"assets/assets/images/sprites/player/idle.png": "60ad351d46032e7399e16b31ccc5f8d7",
"assets/assets/images/sprites/player/white.png": "2cee074a977c621d9094029965a47537",
"assets/assets/images/sprites/player/red.png": "433b66807699fa91e8571f540676bc70",
"assets/assets/audio/shuriken.mp3": "5282d7ffa15bde088ae4b9c2ce43403b",
"assets/assets/audio/pause.mp3": "fd7f3ff3f2c802d1fd238a4378fcb8fb",
"assets/assets/audio/kunai.mp3": "10533cd7f05218a07e63bf98a9c86757",
"assets/assets/audio/music.mp3": "82b0acf2a46c69b1ac8864923ec9f3ab",
"assets/assets/audio/bounce.mp3": "b66419eb412b4f07a617b78fb8dace0a",
"assets/assets/audio/heal.mp3": "c16fd60869ffb4675bd3fa2161603d0a",
"assets/assets/audio/kill.mp3": "fa9ab470ef8c7d83238f29072bf00bfd",
"assets/assets/audio/bomb.mp3": "9bc0b2bc3507eb5f8659b2b95cb41665",
"assets/assets/fonts/FutilePro.ttf": "06d8ae93d6b868f378d5f5c0df36f1d1",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
