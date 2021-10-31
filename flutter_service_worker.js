'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "14bf6f9ad22d30aba51b0744f1c74ee3",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "f410ab731d0b80e5b57dcee8ea67c9c2",
"assets/assets/images/1parallax.png": "87940249f2f294d7e3a505fe8daccd07",
"assets/assets/images/3parallax.png": "cc2d6a44c9c559786473c59eeb2eabf0",
"assets/assets/images/kill.png": "6394df6adfe70c573c43920b88cb3a4e",
"assets/assets/images/18.png": "75a1e2cc4e0dc89410723403afd3be69",
"assets/assets/images/die.png": "8716fdb00460435eabb048c08b0f8bca",
"assets/assets/images/icons_8_17.png": "420bcfd8b591d5c1ee623ceee141d84d",
"assets/assets/images/BG_01.png": "f149f1a9e29c985537d11a618cd6d86a",
"assets/assets/images/eatcandy.png": "b116f445feee0b3c8d51ca8ca3cff78d",
"assets/assets/images/icons_8_30.png": "598b3dfa6b604ad98d19d663f993c7e8",
"assets/assets/images/win.png": "5fd85ec451f625ac3c740c6b37bdccce",
"assets/assets/images/2parallax.png": "c91b720daf1d7e1caa4de2b770e004f2",
"assets/assets/images/5parallax.png": "b25848446884d98a8c23620e5b344405",
"assets/assets/images/button-play-main.png": "bfa9080a149fa1028fb0d2bfe56a5bd0",
"assets/assets/images/welcome.png": "fdc205dd894cffad5120a372f7d374ce",
"assets/assets/images/7parallax.png": "78d184fe3aa4a22bbb38615cc2318d8e",
"assets/assets/images/cobacharun.png": "09686759b685236396ef7e6ce488de25",
"assets/assets/images/4parallax.png": "5a57b77fea332cf923e5cf93e9260236",
"assets/assets/images/icons_8_48.png": "17a899af28ccbc7190d0656a39583817",
"assets/assets/images/gameover.png": "c5fb854e287d22a68764b092e1acbfc2",
"assets/assets/images/9.png": "33b1a48c6eeb29a8b2fe8ca5dbfce1c4",
"assets/assets/images/ghost.png": "7d3f3e07dfb104b49c757f18f58fcab2",
"assets/assets/images/40.png": "22dffd3c20019082e68f22d8692ca478",
"assets/assets/images/4.png": "f0b3e1dfa0797541f80de04318e33af1",
"assets/assets/images/6parallax.png": "37bab5921fb2592ff82a611664aa5bd4",
"assets/assets/images/24.png": "7f4f866f21f1e6c62248042d1ddbdf96",
"assets/assets/audio/kick.wav": "30f49ddab93dd222b724ceab696d328f",
"assets/assets/audio/jump.wav": "39875339bdf7b1defff19312cc28cef4",
"assets/assets/audio/rock.mp3": "1ff2760ae4829ea92d9c3edbb09aae44",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.json": "273f83d85c807c1fbbef2d105940b787",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"main.dart.js": "383710250ecd19c11c454fce7bd17460",
"manifest.json": "857f3991cc0ae3ac77c4338e821d7a9d",
"index.html": "ebf322dd243102502fa0c2768dc0aa9c",
"/": "ebf322dd243102502fa0c2768dc0aa9c"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
